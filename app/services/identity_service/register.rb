# frozen_string_literal: true

module IdentityService
  class Register
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def call!
      return unless server?
      PeerInfo.find_or_initialize_by(public_key: public_key).tap do |peer_info|
        next if peer_info.persisted?
        peer_info.ip = ip
        peer_info.username = "UNKNOWN"
        peer_info.friend_ship_status = :stranger
        peer_info.save!
      end
    end

    def ip
      request.headers["Gateway"]
    end

    def public_key
      request.headers["Public-Key"]
    end

    def server?
      request.headers["Client"] == "server"
    end
  end
end
