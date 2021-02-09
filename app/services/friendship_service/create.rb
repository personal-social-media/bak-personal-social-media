# frozen_string_literal: true

module FriendshipService
  class Create
    attr_reader :request, :current_peer_info, :new_record

    def initialize(request, current_peer_info)
      @request = request
      @current_peer_info = current_peer_info
    end

    def call!
      return current_peer_info if current_peer_info.present? && !unknown?

      @current_peer_info = build_new_current_peer_info

      return current_peer_info if new_record
      return current_peer_info unless unknown?

      current_peer_info.tap do |unknown|
        unknown.update_attribute(:friend_ship_status, :requested)
        unknown.fetch_more_information
      end
    end

    private
      def build_new_current_peer_info
        return current_peer_info if current_peer_info.present?
        @new_record = true
        PeerInfo.create!(ip: ip, username: "UNKNOWN", public_key: public_key, friend_ship_status: :requested)
      end

      def unknown?
        current_peer_info.stranger?
      end

      def public_key
        request.headers["Public-Key"]
      end

      def ip
        request.headers["Gateway"]
      end
  end
end
