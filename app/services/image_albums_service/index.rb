# frozen_string_literal: true

module ImageAlbumsService
  class Index
    extend Memoist
    attr_reader :params, :image_albums

    def initialize(params)
      @params = params
    end

    def call!
      @image_albums = ImageAlbum
      @image_albums = apply_pagination
      self
    end

    memoize def gallery_elements
      GalleryElement.where(most_recent: true).where(image_album_id: image_albums.map(&:id)).includes(:element).group_by(&:image_album_id)
    end

    private
      def apply_pagination
        image_albums.page(params[:page]).per(21)
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
