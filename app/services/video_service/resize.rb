# frozen_string_literal: true

module VideoService
  class Resize
    extend Memoist

    attr_reader :versions, :original
    def initialize(versions, original)
      @versions = versions
      @original = original
    end

    def call!
      versions.tap do |v|
        v[:original_screenshot] = original_image
        screenshot.rewind
        v[:thumbnail_screenshot] = thumbnail

        video.transcode(transcoded_original.path, short_options)
        transcoded_original.rewind

        v[:short] = transcoded_original
      end
    end

    private
      def original_image
        image_pipeline.saver(strip: true, quality: 89).resize_to_limit!(1200, 1200)
      end

      def thumbnail
        image_pipeline.saver(strip: true, quality: 75).resize_to_limit!(160, 160)
      end

      memoize def video_screenshot_default
        video.screenshot(screenshot.path).path
      end

      memoize def pipeline
        ImageProcessing::Vips.source(original)
      end

      memoize def screenshot
        Tempfile.new %w[screenshot .jpg]
      end

      memoize def transcoded_original
        Tempfile.new %w[transcoded .mp4]
      end

      def short_options
        default_transcode_options.merge(
          resolution: "240x240",
          video_bitrate: 300, video_bitrate_tolerance: 100,
          custom: %w(-crf 23 -t 5 -an)
        )
      end

      def original_transcode_options
        default_transcode_options
      end

      def default_transcode_options
        {
          threads: 1,
          video_codec: "libx264",
          x264_preset: "ultrafast",
        }
      end

      memoize def image_pipeline
        ImageProcessing::Vips.source(video_screenshot_default).convert("webp")
      end

      memoize def video
        FFMPEG::Movie.new(original.path)
      end
  end
end
