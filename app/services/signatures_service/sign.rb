# frozen_string_literal: true

module SignaturesService
  class Sign
    include IdentityService::SignedRequest
    attr_reader :content

    def initialize(content)
      @content = content.to_s
    end

    def call!
      Base32.encode(sign(content))
    end
  end
end
