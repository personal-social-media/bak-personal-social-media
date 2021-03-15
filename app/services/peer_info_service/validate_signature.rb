# frozen_string_literal: true

module PeerInfoService
  class ValidateSignature
    attr_reader :peer_info

    def initialize(peer_info)
      @peer_info = peer_info
    end

    def call!
      pk = OpenSSL::PKey::RSA.new(public_key)
      pk.verify(OpenSSL::Digest::SHA256.new, Base32.decode(signature), peer_info_json)
    end

    private
      def peer_info_json
        PeerInfoPresenter.new(peer_info).render_as_signature.to_json
      end

      delegate :public_key, :signature, to: :peer_info
  end
end
