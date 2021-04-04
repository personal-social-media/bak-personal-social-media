# frozen_string_literal: true

module ConversationsService
  class ConversationsUpdate
    class Error < Exception; end
    include IdentityService::SignedRequest
    attr_reader :conversation, :update_params
    def initialize(conversation, update_params)
      @conversation = conversation
      @update_params = update_params
    end

    def call!
      if body.present?
        response = HTTP.timeout(timeout).headers(signed_headers(url)).put(url, json: body)
        raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399
      end

      conversation.update!(local_params)
    end

    private
      def url
        "https://#{peer_info.ip}/api/conversations"
      end

      def timeout
        10
      end

      def local_params
        {
          is_typing: is_typing
        }
      end

      def body
        return nil if is_typing.nil?
        {
          conversation: {
            is_typing: is_typing
          }
        }
      end

      def is_typing
        update_params[:is_typing]
      end

      delegate :peer_info, to: :conversation
  end
end
