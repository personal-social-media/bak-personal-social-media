# frozen_string_literal: true

module AttachmentsService
  class UrlFor
    class VideoUrl
      attr_reader :video, :request

      def initialize(video, request)
        @video = video
        @request = request
      end

      def all_urls
        {
          type: "video",
          original: get_version(:original),
          short: get_version(:short),
          original_screenshot: video.video_url(:original_screenshot),
          thumbnail_screenshot: video.video_url(:thumbnail_screenshot),
        }
      end

      def url_for_device
        root_path + video.video_url(:original)
      end

      def url_for_device_hash(hash)
        hash["original"]
      end

      def get_version(name)
        root_path + video.video_url(name).to_s
      end

      def root_path
        @root_path ||= Rails.application.secrets.dig(:load_balancer_address)
      end
    end
  end
end
