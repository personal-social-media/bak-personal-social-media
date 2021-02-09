# frozen_string_literal: true

module Client
  class FriendshipsController < BaseController
    before_action :require_current_peer

    def create
      @peer_info = FriendshipClientService::Create.new(current_peer).call!
    rescue FriendshipClientService::Create::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end

    def destroy
      FriendshipClientService::Destroy.new(current_peer, params[:option]).call!

      head :ok
    rescue FriendshipClientService::Create::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end

    private
      def current_peer
        @current_peer ||= PeerInfo.find_by(id: params[:id])
      end

      def require_current_peer
        head 404 if current_peer.blank?
      end
  end
end
