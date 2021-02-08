# frozen_string_literal: true

module NodeVerifyRequest
  def verify_node_request
    if IdentityService::VerifyRequest.new(
      request.original_url,
      request.headers["Public-Key"],
      request.headers["Url-Signed"],
      request.headers["Real-User-Agent"],
      request.headers["Client"]
    ).call!
      IdentityService::Register.new(request).call! unless respond_to?(:ignore_register)
    else
      head 403
    end
  end

  def verify_not_blocked
    head 403 if friend&.blocked?
  end

  def require_friend
    head 403 unless is_friend?
  end

  def is_friend?
    return @is_friend if defined? @is_friend
    return @is_friend = false if friend.blank?
    @is_friend = friend.self? || friend.accepted?
  end

  def friend
    return @friend if defined? @friend
    @friend = IdentityService::GetFriend.new(request).call!
  end

  def is_server?
    request["Client"] == "server"
  end

  def require_server
    head 403 unless is_friend?
  end
end
