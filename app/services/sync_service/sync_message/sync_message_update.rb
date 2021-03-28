# frozen_string_literal: true

module SyncService
  class SyncMessage
    class SyncMessageUpdate < SyncService::BaseSync
      attr_reader :message, :request

      def initialize(message)
        @message = message
      end

      def call_update!
        @request = make_request
        check_response(request)
      end

      private
        def make_request
          hydra = Typhoeus::Hydra.hydra
          Typhoeus::Request.new(url, method: :patch, headers: default_headers(url).merge(json_headers), body: body).tap do |r|
            hydra.queue(r)
            hydra.run
          end
        end

        def url
          "https://#{message.peer_info.ip}/api/messages/#{message.remote_id}"
        end

        def body
          {
            message: {
              read: message.read
            }
          }.to_json
        end
    end
  end
end
