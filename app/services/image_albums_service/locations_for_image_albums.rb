# frozen_string_literal: true

module ImageAlbumsService
  class LocationsForImageAlbums
    extend Memoist
    attr_reader :image_albums_ids

    def initialize(image_albums_ids)
      @image_albums_ids = image_albums_ids
    end

    def locations_for_image_album(image_album)
      id = image_album.id
      images_location.select do |row|
        row[0] == id
      end.map do |row|
        row[1]
      end.uniq
    end

    private
      memoize def images_location
        ImageFile.joins(:gallery_elements).where("gallery_elements.image_album_id": image_albums_ids)
                 .group("gallery_elements.image_album_id", "location_name").where.not(location_name: nil)
                 .count
                 .keys
      end
  end
end
