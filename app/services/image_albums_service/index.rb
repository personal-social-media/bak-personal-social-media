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
        ImageAlbum.includes(:image_files).where(image_files: { most_recent: true }).order("image_files.id": :desc)
      end

      def convert_to_list
        image_albums
        # return image_albums if base_query == ImageAlbum
        # image_albums.map(&:searchable)
      end

      memoize def images_location
        ImageFile.where(image_album_id: image_albums.map(&:id))
                 .group(:image_album_id, "location_name").where.not(location_name: nil)
                 .count
                 .keys
      end

      memoize def search
        params[:q]
      end
  end
end
