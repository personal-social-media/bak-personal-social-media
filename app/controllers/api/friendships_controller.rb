# frozen_string_literal: true

module Api
  class FriendshipsController < BaseController
    extend Memoist
    before_action :require_server
    before_action :verify_node_request
    before_action :require_current_peer_info, only: %i(show destroy update)

    def show
      @peer_info = current_peer_info
    end

    def create
      @peer_info = FriendshipService::Create.new(request, current_peer_info)
    end

    def destroy
      head :ok
    end

    def update
    end

    def ignore_register
      true
    end

    private
      def current_peer_info
        friend
      end

      def require_current_peer_info
        head 404 if current_peer_info.blank?
      end
  end
end
