# frozen_string_literal: true

module CacheCommentsService
  class UpdateCacheComment
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :update_params, :cache_comment
    def initialize(update_params, cache_comment)
      @update_params = update_params
      @cache_comment = cache_comment
    end

    def call!
      response = HTTP.timeout(timeout).headers(signed_headers(url)).patch(url, json: body)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      cache_comment.update!(update_params)
    end

    private
      def timeout
        10
      end

      def body
        {
          comment: {
            comment_type: update_params[:comment_type],
          }
        }
      end

      def url
        "https://#{peer_info.ip}/api/comments/#{cache_comment.remote_id}"
      end

      delegate :subject, to: :cache_comment
      delegate :peer_info, to: :subject
  end
end
