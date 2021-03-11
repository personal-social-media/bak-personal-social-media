# frozen_string_literal: true

module CacheReactionsService
  class DestroyCacheReaction
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :cache_reaction
    def initialize(cache_reaction)
      @cache_reaction = cache_reaction
    end

    def call!
      response = HTTP.timeout(timeout).headers(signed_headers(url)).delete(url)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      cache_reaction.destroy
    end

    private
      def timeout
        10
      end

      def url
        "https://#{peer_info.ip}/api/reactions/#{cache_reaction.remote_id}"
      end

      delegate :subject, to: :cache_reaction
      delegate :peer_info, to: :subject
  end
end
