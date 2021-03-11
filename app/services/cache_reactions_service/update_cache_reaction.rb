# frozen_string_literal: true

module CacheReactionsService
  class UpdateCacheReaction
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :update_params, :cache_reaction
    def initialize(update_params, cache_reaction)
      @update_params = update_params
      @cache_reaction = cache_reaction
    end

    def call!
      response = HTTP.timeout(timeout).headers(signed_headers(url)).patch(url, json: body)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      cache_reaction.update!(update_params)
    end

    private
      def timeout
        10
      end

      def body
        {
          reaction: {
            reaction_type: update_params[:reaction_type],
          }
        }
      end

      def url
        "https://#{peer_info.ip}/api/reactions/#{cache_reaction.remote_id}"
      end

      delegate :subject, to: :cache_reaction
      delegate :peer_info, to: :subject
  end
end
