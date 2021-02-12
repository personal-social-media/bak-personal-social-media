# frozen_string_literal: true

module ImageAlbumsService
  class Index
    extend Memoist
    attr_reader :params, :image_albums

    def initialize(params)
      @params = params
    end

    def call!
      @image_albums = base_query
      @image_albums = apply_pagination
      convert_to_list
      self
    end



    private
      def apply_pagination
        image_albums.page(params[:page]).per(20)
      end

      memoize def base_query
        ImageAlbum.includes(:gallery_elements).preload(gallery_elements: :element).where(gallery_elements: { most_recent: true })
      end

      def convert_to_list
        image_albums
      end

      memoize def images_location
        LocationsForImageAlbums.new(image_albums.map(&:id))
      end

      memoize def search
        params[:q]
      end

      delegate :locations_for_image_album, to: :images_location
  end
end
