# frozen_string_literal: true

module FriendshipService
  class Create
    attr_reader :request, :current_peer_info

    def initialize(request, current_peer_info)
      @request = request
      @current_peer_info = current_peer_info
    end

    def call!
      return current_peer_info if current_peer_info.present? && !unknown?

      @current_peer_info = build_new_current_peer_info
    end

    private
      def build_new_current_peer_info
        return current_peer_info if current_peer_info.present?

        PeerInfo.create!(ip: request.remote_ip, username: "UNKNOWN")
      end

      def unknown?
        current_peer_info.username == "UNKNOWN"
      end
  end
end
