# frozen_string_literal: true

module ImagesService
  class AddMetadataToImage
    extend Memoist
    attr_reader :tmp_file, :record

    def initialize(tmp_file, record)
      @tmp_file = tmp_file
      @record = record
    end

    def call!
      record.update!(saved_fields)
    end

    private
      def saved_fields
        {}.tap do |f|
          f[:location_name] = lat_lng.present? ? location_name : nil
          f[:metadata] = exif
        end.compact
      end

      def location_name
        search = geocoder.search(*lat_lng)
        fields = search.slice(:name, :admin1, :admin2, :country).values
        fields.compact.uniq.join(" ")
      end

      memoize def exif
        Exiftool.new(tmp_file.path).to_hash
      end

      memoize def lat_lng
        [
          exif[:gps_latitude],
          exif[:gps_longitude],
        ].compact
      end

      memoize def geocoder
        OfflineGeocoder.new
      end
  end
end
