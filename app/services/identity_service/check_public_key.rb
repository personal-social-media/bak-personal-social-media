# frozen_string_literal: true

module IdentityService
  class CheckPublicKey
    include SignedRequest
    attr_reader :public_key, :ip
    def initialize(public_key, ip)
      @ok = true
      @public_key = public_key
      @ip = ip
    end

    def call!
      response = HTTP.headers(signed_headers(url)).timeout(20).get(url)
      response.body.to_s == public_key
    rescue TimeoutError
      false
    end

    private
      def url
        "https://#{ip}/public_key"
      end
  end
end
