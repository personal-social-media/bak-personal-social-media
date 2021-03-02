# frozen_string_literal: true

module ImagesService
  class AddMetadataToVideo
    extend Memoist
    attr_reader :tmp_file, :ctx, :metadata

    def initialize(tmp_file, ctx, metadata)
      @tmp_file = tmp_file
      @ctx = ctx
      @metadata = metadata
    end

    def call!
      record.update!(saved_fields)
    end

    private
      def saved_fields
        {}.tap do |f|
          next unless allow_call?
          f[:location_name] = lat_lng.present? ? location_name : nil
          f[:metadata] = exif
          f[:real_created_at] = created_at
          f[:duration_seconds] = duration_seconds
        end.compact
      end

      def location_name
        search = geocoder.search(*lat_lng)
        fields = search.slice(:name, :admin1, :admin2, :country).values
        fields.compact.uniq.join(" ")
      end

      def record
        ctx[:record]
      end

      def filename
        metadata["filename"]
      end

      def created_at
        exif[:gps_date_time]
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

      def allow_call?
        !Rails.env.test?
      end

      def duration_seconds
        movie.duration.to_i
      end

      memoize def movie
        FFMPEG::Movie.new(tmp_file.path)
      end
  end
end
