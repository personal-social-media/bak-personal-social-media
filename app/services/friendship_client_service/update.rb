# frozen_string_literal: true

module FriendshipClientService
  class Update
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :peer_info, :option
    def initialize(peer_info, option)
      @peer_info = peer_info
      @option = option
    end

    def call!
      return peer_info unless peer_info.pending_accept?

      response = HTTP.timeout(timeout).headers(signed_headers(url)).patch(url, json: data)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      if option == "accepted"
        peer_info.update!(friend_ship_status: :accepted)
      elsif option == "declined"
        peer_info.update!(friend_ship_status: :declined)
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

      def data
        {
          friendship: {
            friend_ship_status: option
          }
        }
      end
  end
end
