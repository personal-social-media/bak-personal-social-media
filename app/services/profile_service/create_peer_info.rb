# frozen_string_literal: true

module ProfileService
  class CreatePeerInfo
    include IdentityService::SignedRequest
    attr_reader :profile, :peer_info

    def initialize(profile)
      @profile = profile
    end

    def call!
      @peer_info = PeerInfo.create!(
        friend_ship_status: :self,
        ip: ip,
        username: profile.username,
        public_key: public_key,
        name: profile.username
      )
      propagate_to_registry if Rails.env.production?
      peer_info
    end

    def ip
      URI.parse(Rails.application.secrets.dig(:load_balancer_address)).host
    end

    def propagate_to_registry
      SyncService::SyncPeerInfo.new(peer_info).propagate_to_registry
    end
  end
end
