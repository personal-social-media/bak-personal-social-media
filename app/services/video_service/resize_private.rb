# frozen_string_literal: true

module VideoService
  class ResizePrivate
    extend Memoist

    attr_reader :versions, :original
    def initialize(versions, original)
      @versions = versions
      @original = original
    end

    def call!
      versions.tap do |v|
        v[:screenshot] = File.open(video.screenshot(screenshot.path).path)
        v[:short] = File.open(video.transcode(transcoded_original.path, short_options).path)
      end
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
        resolution: "120x120",
        video_bitrate: 300, video_bitrate_tolerance: 100,
        frame_rate: 2,
        custom: %w(-vcodec copy -crf 23 -t 10)
      )
    end

    def original_transcode_options
      default_transcode_options
    end

    def default_transcode_options
      {
        threads: 1,
        video_codec: "libx264",
        x264_preset: "veryfast",
      }
    end

    memoize def video
      FFMPEG::Movie.new(original.path)
    end
  end
end
