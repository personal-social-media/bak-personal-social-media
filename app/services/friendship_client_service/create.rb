# frozen_string_literal: true

module FriendshipClientService
  class Create
    class Error < Exception; end
    include IdentityService::SignedRequest
    attr_reader :peer_info
    def initialize(peer_info)
      @peer_info = peer_info
    end

    def call!
      return peer_info unless peer_info.stranger?
      PeerInfo.transaction do
        peer_info.update!(friend_ship_status: :requested)
        response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url)
        raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399
      end
      peer_info
    end

    private
      def timeout
        10
      end

      def url
        "https://#{peer_info.ip}/api/friendship"
      end
  end
end
