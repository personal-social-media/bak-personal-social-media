# frozen_string_literal: true

class PeerInfoPresenter
  attr_reader :peer_info
  def initialize(peer_info)
    @peer_info = peer_info
  end

  def render
    peer_info.as_json(only: default_fields)
  end

  def render_as_signature
    {
      username: peer_info.username,
      name: peer_info.name,
      avatars: peer_info.avatars&.sort&.to_h,
      ip: peer_info.ip
    }
  end

  private
    def default_fields
      %i(id name username avatars public_key ip)
    end

    def signature_fields
      %i(username name avatars ip)
    end
end
