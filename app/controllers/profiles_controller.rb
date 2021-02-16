# frozen_string_literal: true

# internal use
class ProfilesController < ApplicationController
  extend Memoist
  before_action :require_current_user
  before_action :require_current_peer

  def show
    @title = current_peer.name
  end

  def require_current_peer
    redirect_to root_path, notice: "Peer not found" if current_peer.blank?
  end

  memoize def current_peer
    PeerInfo.find_by(id: params[:id])
  end

  def is_current_user?
    current_peer.id == current_peer.peer_info.id
  end

  helper_method :current_peer, :is_current_user?
end
