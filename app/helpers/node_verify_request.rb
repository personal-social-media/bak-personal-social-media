# frozen_string_literal: true

module NodeVerifyRequest
  extend Memoist

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

  memoize def is_friend?
    return false if friend.blank?
    friend.self? || friend.accepted?
  end

  memoize def friend
    IdentityService::GetFriend.new(request).call!
  end

  def is_server?
    request["Client"] == "server"
  end

  def require_server
    head 403 unless is_friend?
  end
end
