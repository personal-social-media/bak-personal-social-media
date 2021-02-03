# frozen_string_literal: true

module ProfileService
  class CreatePeerInfo
    include IdentityService::SignedRequest
    attr_reader :profile

    def initialize(profile)
      @profile = profile
    end

    def call!
      PeerInfo.create!(
        friend_ship_status: :self,
        ip: ip, friend: false,
        username: profile.username,
        public_key: public_key,
        name: profile.username
      )
    end

    def ip
      URI.parse(Rails.application.secrets.dig(:load_balancer_address)).host
    end
  end
end
