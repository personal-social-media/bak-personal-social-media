# frozen_string_literal: true

module IdentityService
  module SignedRequest
    mattr_accessor :extra_headers, default: {}

    def signed_headers(url)
      {
        "User-Agent": "Personal Social Media",
        "Url-Signed": private_key.sign(OpenSSL::Digest::SHA256.new, url),
        "Public-Key": private_key.public_key.to_pem,
      }.merge!(extra_headers)
    end

    def private_key
      return @@private_key if defined? @@private_key
      key = File.read(Rails.application.secrets.dig(:profile, :keys_location) + "/private_key.pem")

      @@private_key = OpenSSL::PKey::RSA.new(key)
    end

    def public_key
      return @@public_key if defined? @@public_key
      @@public_key = private_key.public_key.to_pem
    end
  end
end
