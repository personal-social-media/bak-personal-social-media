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

    def locations_for_image_album(image_album)
      id = image_album.id
      images_location.select do |row|
        row[0] == id
      end.map do |row|
        row[1]
      end
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
        ImageFile.joins(:gallery_elements).where("gallery_elements.image_album_id": image_albums.map(&:id))
                 .group("gallery_elements.image_album_id", "location_name").where.not(location_name: nil)
                 .count
                 .keys
      end

      memoize def search
        params[:q]
      end
  end
end
