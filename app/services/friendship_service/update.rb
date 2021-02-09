# frozen_string_literal: true

module FriendshipService
  class Update
    attr_reader :current_peer_info, :update_params
    def initialize(current_peer_info, update_params)
      @current_peer_info = current_peer_info
      @update_params = update_params
    end

    def call!
      current_peer_info.tap do |peer_info|
        next unless is_permitted?
        next unless is_permitted_state?
        peer_info.update_attribute(:friend_ship_status, friend_ship_status)
      end
    end

    private
      def is_permitted?
        current_peer_info.requested?
      end

      def is_permitted_state?
        %w(accepted declined).include?(friend_ship_status)
      end

      def friend_ship_status
        update_params[:friend_ship_status]
      end
  end
end
