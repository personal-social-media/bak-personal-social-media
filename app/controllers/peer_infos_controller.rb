# frozen_string_literal: true

# internal use
class PeerInfosController < ActionController::Base
  include SessionHelper
  before_action :require_current_user
  before_action :require_current_peer, only: :show

  def index
    @peer_infos = PeerInfoService::Search.new(query: scoped_query, page: params[:page], limit: 10,
                                              name_like: params[:name_like],
                                              ids: params[:peer_ids]).call!
  end

  def search_public_keys
    @peer_infos = PeerInfoService::Search.new(query: scoped_query, limit: 10,
                                              public_keys: params[:public_keys]).call!

    render :index
  end

  def create
    peer_info_params = params.require(:peer_info).permit(:public_key, :username, :name, :ip, avatars: {})
    @peer_info = PeerInfoService::Create.new(peer_info_params).call!
    render :show

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: "unable to create peer info, #{e.message}" }, status: 422
  end

  def update
  end

  def show
    @peer_info = current_peer
  end

  def destroy
    current_peer.update!(friend_ship_status: :blocked)
  end

  private
    def require_current_peer
      head 404 if current_peer.blank?
    end

    def current_peer
      @current_peer ||= base_query.find_by(id: params[:id])
    end

    def scoped_query
      scope = params[:scope]
      return base_query if scope.blank?
      return base_query.active if scope == "active"
      base_query
    end

    def base_query
      PeerInfo
    end
end
