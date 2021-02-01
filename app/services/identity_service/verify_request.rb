# frozen_string_literal: true

module IdentityService
  class VerifyRequest
    attr_reader :original_url, :public_key, :signed_original_url, :user_agent

    def initialize(original_url, public_key, signed_original_url, user_agent)
      @original_url = original_url
      @public_key = public_key
      @signed_original_url = signed_original_url
      @user_agent = user_agent
    end

    def call!
      return false if original_url.blank? || public_key.blank? || signed_original_url.blank?
      pk = OpenSSL::PKey::RSA.new(public_key)
      pk.verify(OpenSSL::Digest::SHA256.new, signed_original_url, original_url)
    end
  end
end
