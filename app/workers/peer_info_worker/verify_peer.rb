# frozen_string_literal: true

module PeerInfoWorker
  class VerifyPeer < ApplicationWorker
    attr_reader :peer
    def perform(peer_id)
      @peer = PeerInfo.find_by(id: peer_id)
      return if peer.blank?
    end

    def call!
      return mark_fake unless check_public_key
    end

    def check_public_key
      IdentityService::CheckPublicKey.new(public_key, ip).call!
    end

    def mark_fake
      peer.update_columns(friend_ship_status: :fake)
    end

    delegate :ip, :public_key, to: :peer
  end
end
