# frozen_string_literal: true

# internal use
class ProfilesController < ApplicationController
  extend Memoist
  before_action :require_current_user
  before_action :require_current_peer, only: %i(show)

  def show
    @title = current_peer.name
  end

  def reset_counter
    ProfileService::ResetCounter.new(current_user, params.require(:profile).permit(:counter)).call!
    head :ok
  rescue ProfileService::ResetCounter::ResetError => e
    render json: { error: e.error }, status: 422
  end

  def require_current_peer
    render_not_found if current_peer.blank?
  end

  memoize def current_peer
    PeerInfo.find_by(id: params[:id])
  end

  def is_current_user?
    current_peer.id == current_peer.peer_info.id
  end

  helper_method :current_peer, :is_current_user?
end
