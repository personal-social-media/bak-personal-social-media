# frozen_string_literal: true

module FriendshipService
  class Create
    attr_reader :request, :current_peer_info, :new_record, :node_verification

    def initialize(request, current_peer_info, node_verification)
      @request = request
      @current_peer_info = current_peer_info
      @node_verification = node_verification
    end

    def call!
      return current_peer_info if current_peer_info.present? && !unknown?

      @current_peer_info = build_new_current_peer_info

      return current_peer_info if new_record
      return current_peer_info unless unknown?

      current_peer_info.tap do |unknown|
        unknown.update_attribute(:friend_ship_status, :pending)
        unknown.fetch_more_information
      end
    end

    private
      def build_new_current_peer_info
        return current_peer_info if current_peer_info.present?
        @new_record = true
        PeerInfo.create!(ip: ip, username: "UNKNOWN", public_key: public_key, friend_ship_status: :pending_accept)
      end

      def unknown?
        current_peer_info.stranger?
      end

      def ip
        request.headers["Gateway"]
      end

      def public_key
        node_verification.real_public_key
      end
  end
end
