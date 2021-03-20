# frozen_string_literal: true

module CacheReactionsService
  class UpdateCacheReaction
    extend Memoist
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
        "#{local_request.scheme}://#{peer_info.ip}#{local_request.port}/api/reactions/#{cache_reaction.remote_id}"
      end

      def local_request
        @local_request ||= PeerInfoService::LocalRequest.new(peer_info)
      end

      delegate :peer_info, to: :cache_reaction
  end
end
