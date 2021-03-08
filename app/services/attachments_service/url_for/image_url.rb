# frozen_string_literal: true

module AttachmentsService
  class UrlForm
    class ImageUrl
      attr_reader :image, :request

      def initialize(image, request)
        @image = image
        @request = request
      end

      def all_urls
        {
          type: "image",
          desktop: root_path + image.image_url(:original),
          mobile: root_path + image.image_url(:mobile),
          thumbnail: root_path + image.image_url(:thumbnail),
        }
      end

      def url_for_device
        type = case request.headers["Client"]
               when "desktop"
                 :original
               else
                 :mobile
        end
        root_path + image.image_url(type)
      end

      def url_for_device_hash
        type = case request.headers["Client"]
               when "desktop"
                 "original"
               else
                 "mobile"
        end
        hash[type]
      end

      def root_path
        @root_path ||= Rails.application.secrets.dig(:load_balancer_address)
      end
    end
  end
end
