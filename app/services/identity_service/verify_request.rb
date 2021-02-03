# frozen_string_literal: true

module IdentityService
  class VerifyRequest
    attr_reader :original_url, :public_key, :signed_original_url, :user_agent, :client

    def initialize(original_url, public_key, signed_original_url, user_agent, client)
      @original_url = original_url
      @public_key = public_key
      @signed_original_url = signed_original_url
      @user_agent = user_agent
      @client = client
    end

    def call!
      return false if original_url.blank? || public_key.blank? || signed_original_url.blank? ||
                      client.blank? || user_agent.blank?

      return false unless user_agent == "Personal Social Media"
      pk = OpenSSL::PKey::RSA.new(real_public_key)
      pk.verify(OpenSSL::Digest::SHA256.new, real_signed_original_url, original_url)
    end

    def real_signed_original_url
      Base32.decode(signed_original_url)
    end

    def real_public_key
      Base32.decode(public_key)
    end
  end
end
