# frozen_string_literal: true

module IdentityService
  class GetPeerInfo
    extend Memoist
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def call!
      return nil if public_key.blank?
      PeerInfo.find_by(public_key: public_key)
    end

    memoize def public_key
      key = request.headers["Public-Key"]
      return nil if key.blank?

      return key if request["Client"] == "server"
      Base32.decode(key)
    end
  end
end
