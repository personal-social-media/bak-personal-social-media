# frozen_string_literal: true

module ConversationsService
  class ConversationsCreate
    class Error < Exception; end
    include IdentityService::SignedRequest
    attr_reader :peer_info
    def initialize(params)
      @peer_info = PeerInfo.find_by!(id: params[:peer_info_id])
    end

    def call!
      return @conversation = peer_info.conversation if peer_info.conversation.present?

      response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      Conversation.create!(peer_info: peer_info)
    end

    private
      def url
        "https://#{peer_info.ip}/api/conversations"
      end

      def timeout
        10
      end
  end
end
