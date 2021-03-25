# frozen_string_literal: true

module PeerInfoService
  class ValidateSignedContent
    attr_reader :peer_info, :content, :signed_content, :decode

    def initialize(peer_info, content, signed_content, decode: false)
      @peer_info = peer_info
      @content = content
      @signed_content = signed_content
      @decode = decode
    end

    def call!
      public_key.verify(OpenSSL::Digest::SHA256.new, signature, content)
    rescue OpenSSL::PKey::RSAError
      false
    end

    def public_key
      @public_key ||= OpenSSL::PKey::RSA.new(peer_info.public_key)
    end

    def signature
      return @signature if defined? @signature
      if decode
        @signature = Base32.decode(signed_content)
      else
        @signature = signed_content
      end
    end
  end
end
