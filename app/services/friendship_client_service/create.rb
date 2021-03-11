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
      response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399
      peer_info.update!(friend_ship_status: :requested)
      handle_dev_accept(response)
      peer_info
    end

    private
      def timeout
        10
      end

      def url
        "https://#{peer_info.ip}/api/friendship"
      end

      def handle_dev_accept(response)
        return if ENV["DEVELOPER"].blank?
        json = JSON.parse(response.body.to_s)
        friend_ship_status = json["friendship"]["friend_ship_status"]

        peer_info.update!(friend_ship_status: :accepted) if friend_ship_status == "accepted"
      end
  end
end
