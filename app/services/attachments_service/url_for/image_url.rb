# frozen_string_literal: true

module AttachmentsService
  class UrlFor
    class ImageUrl
      attr_reader :image, :request

      def initialize(image, request)
        @image = image
        @request = request
      end

      def all_urls
        {
          type: "image",
          desktop: get_version(:original),
          mobile: get_version(:mobile),
          thumbnail: get_version(:thumbnail),
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

      def url_for_device_hash(hash)
        type = case request.headers["Client"]
               when "desktop"
                 "original"
               else
                 "mobile"
        end
        hash[type]
      end

      private
        def get_version(name)
          root_path + image.image_url(name).to_s
        end

        def root_path
          @root_path ||= Rails.application.secrets.dig(:load_balancer_address)
        end
    end
  end
end
