# frozen_string_literal: true

module FriendshipClientService
  class Destroy
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :peer_info, :option
    def initialize(peer_info, option)
      @peer_info = peer_info
      @option = option
    end

    def call!
      return peer_info if peer_info.blocked?
      response = HTTP.timeout(timeout).headers(signed_headers(url)).delete(url, json: data)
      raise Error, "bad server response" if response.status > 399

      if option == "block"
        peer_info.update!(friend_ship_status: :blocked)
      elsif option == "destroy"
        peer_info.destroy
      end
    end

    private
      def timeout
        10
      end

      def url
        "https://#{peer_info.ip}/api/friendship"
      end

      def data
        {
          option: option
        }
      end
  end
end
