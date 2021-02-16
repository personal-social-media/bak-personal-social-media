# frozen_string_literal: true

# external use
module Api
  class FriendshipsController < BaseController
    extend Memoist
    before_action :require_server, only: %i(create update destroy)
    before_action :verify_node_request
    before_action :verify_not_blocked
    before_action :require_current_peer_info, only: %i(show destroy update)

    def show
      @peer_info = current_peer_info
    end

    # FriendshipClientService::Create
    def create
      @peer_info = FriendshipService::Create.new(request, current_peer_info, node_verification).call!
      render :show
    end

    # FriendshipClientService::Destroy
    def destroy
      case params[:option]
      when "destroy"
        current_peer_info.destroy
      when "block"
        current_peer_info.update!(friend_ship_status: :blocked)
      else
        return render json: { error: "invalid action" }, status: 422
      end

      head :ok
    end

    # FriendshipClientService::Update
    def update
      @peer_info = FriendshipService::Update.new(current_peer_info, update_params).call!
      render :show
    end

    def ignore_register
      true
    end

    private
      def update_params
        params.require(:friendship).permit(:friend_ship_status)
      end
  end
end
