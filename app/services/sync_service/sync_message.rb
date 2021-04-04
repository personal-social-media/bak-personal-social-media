# frozen_string_literal: true

module SyncService
  class SyncMessage < BaseSync
    include SyncService::MediaVariants
    attr_reader :message, :request

    def initialize(message)
      @message = message
    end

    def call_create!
      update_message!
      @request = make_request
      check_response(request)
      json = JSON.parse(request.response.body)
      remote_id = json.dig("message", "id")
      message.update!(remote_id: remote_id)
    end

    def call_update!
      SyncMessageUpdate.new(message).call_update!
    end

    private
      def make_request
        hydra = Typhoeus::Hydra.hydra
        Typhoeus::Request.new(url, method: :post, headers: default_headers(url), body: body).tap do |r|
          hydra.queue(r)
          hydra.run
        end
      end

      def url
        "https://#{message.peer_info.ip}/api/messages"
      end

      def update_message!
        message.payload[:images] = images.map! { |i| get_variants_for_image(i) }
        message.payload[:videos] = videos.map! { |v| get_variants_for_video(v) }

        message.generate_signature!
      end

      def images
        message.attached_files.select(&:image?).map!(&:attachment)
      end

      def videos
        message.attached_files.select(&:video?).map!(&:attachment)
      end

      def body
        {
          message: {
            message_type: message.message_type,
            payload: message.payload,
            signature: message.signature
          }
        }
      end

      memoize def stubbed_request
        OpenStruct.new.tap do |r|
          r.headers = {
            "Client" => "desktop"
          }
        end
      end
  end
end
