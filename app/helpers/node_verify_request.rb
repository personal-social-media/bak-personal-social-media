# frozen_string_literal: true

module NodeVerifyRequest
  def verify_node_request
    if Rails.env.test? && !node_verification.call!
      return render json: { error: "url not passing verify_node_request, -> #{request.path}" }, status: 422
    else
      return head 403 unless node_verification.call!
    end

    IdentityService::Register.new(node_verification, request).call! unless respond_to?(:ignore_register)
  end

  def verify_not_blocked
    render json: { error: "you are blocked" }, status: 403 if current_peer_info&.blocked?
  end

  def require_friend
    render json: { error: "you are are not my friend" }, status: 403 unless is_friend?
  end

  def is_friend?
    return @is_friend if defined? @is_friend
    return @is_friend = false if current_peer_info.blank?
    @is_friend = current_peer_info.self? || current_peer_info.accepted? || current_peer_info.requested?
  end

  def current_peer_info
    return @current_peer_info if defined? @current_peer_info
    @current_peer_info = IdentityService::GetPeerInfo.new(request).call!
  end

  def require_current_peer_info
    if current_peer_info.blank?
      render json: { error: "peer info not found" }, status: 404
    else
      logger.info "Processing as peer_info #{current_peer_info.username} / #{current_peer_info.friend_ship_status}"
    end
  end

  def is_server?
    request.headers["Client"] == "server"
  end

  def require_server
    render json: { error: "request must be made from the server" }, status: 422 unless is_server?
  end

  def node_verification
    @node_verification ||= IdentityService::VerifyRequest.new(
      request.original_url,
      request.headers["Public-Key"],
      request.headers["Url-Signed"],
      request.headers["Real-User-Agent"],
      request.headers["Client"]
    )
  end
end
