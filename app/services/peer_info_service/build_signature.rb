# frozen_string_literal: true

module PeerInfoService
  class BuildSignature
    attr_reader :peer_info

    def initialize(peer_info)
      @peer_info = peer_info
    end

    def call!
      json = PeerInfoPresenter.new(peer_info).render_as_signature.to_json
      SignaturesService::Sign.new(json).call!
    end
  end
end
