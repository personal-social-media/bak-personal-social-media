# frozen_string_literal: true

module PeerInfoService
  class LocalRequest
    attr_reader :peer_info
    def initialize(peer_info)
      @peer_info = peer_info
    end

    def port
      return "" unless is_local?
      return ":3000" if peer_info.ip == "localhost"
      ""
    end

    def scheme
      return "https" unless is_local?
      return "http" if peer_info.ip == "localhost"
      "https"
    end

    private
      def is_local?
        !Rails.env.production?
      end
  end
end
