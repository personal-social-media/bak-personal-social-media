# frozen_string_literal: true

module PeerInfoService
  class Create
    attr_reader :peer_info_params
    def initialize(peer_info_params)
      @peer_info_params = peer_info_params
    end

    def call!
      PeerInfo.find_or_initialize_by(public_key: peer_info_params[:public_key]).tap do |peer_info|
        next if peer_info.persisted?
        peer_info.assign_attributes(peer_info_params)
        peer_info.friend_ship_status = :stranger
        peer_info.save!
      end
    end
  end
end
