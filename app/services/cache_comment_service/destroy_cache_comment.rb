# frozen_string_literal: true

module CacheCommentsService
  class DestroyCacheComment
    class Error < Exception; end
    include IdentityService::SignedRequest

    attr_reader :cache_comment
    def initialize(cache_comment)
      @cache_comment = cache_comment
    end

    def call!
      response = HTTP.timeout(timeout).headers(signed_headers(url)).delete(url)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      cache_comment.destroy
    end

    private
      def timeout
        10
      end

      def url
        "https://#{peer_info.ip}/api/comments/#{cache_comment.remote_id}"
      end

      delegate :subject, to: :cache_comment
      delegate :peer_info, to: :subject
  end
end
