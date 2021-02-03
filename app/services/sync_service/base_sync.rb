# frozen_string_literal: true

module SyncService
  class BaseSync
    include Rails.application.routes.url_helpers
    include IdentityService::SignedRequest
    extend Memoist

    attr_reader :method, :url, :body
    class ResponseError < Exception; end

    def timeout
      20
    end

    def default_headers(url)
      signed_headers(url)
    end

    def check_response(request)
      raise ResponseError, "#{request.response.code} #{request.url}" if request.response.code > 399
    end

    # def make_request(method, url, body = nil)
    #   @method = method
    #   @url = url
    #   @body = body
    #
    #   case method
    #   when :get
    #     http_get_request
    #   when :post
    #     http_post_request
    #   when :put
    #     http_post_request
    #   when :patch
    #     http_put_request
    #   when :delete
    #     http_delete_request
    #   else
    #     raise "Invalid method"
    #   end
    # end

    # def client
    #   @client ||= Async::HTTP::Internet.new
    # end
    #
    # def wrap_requests
    #   Async do
    #     yield
    #   end
    # rescue Exception => e
    #     ErrorsService::Handle.new(e, handled_classes: [ResponseError, Timeout::Error]).call!
    # end
    #
    # def http_post_request
    #   response = nil
    #   binding.pry
    #   Timeout.timeout(timeout) do
    #     response = client.post(url, default_headers, [JSON.dump(body)])
    #   end
    #
    #   response.read
    # end
    #
    # def wrap_make_request_thread
    #   return yield if Rails.env.test?
    #
    #   Thread.new do
    #     yield
    #   rescue Exception => e
    #     ErrorsService::Handle.new(e, handled_classes: [ResponseError, Timeout::Error]).call!
    #   end
    # end
    #
    # def friends
    #   PeerInfo.where(friend: true)
    # end
    #
    # private
    #
    # def http_get_request
    #   res = HTTP.timeout(timeout).headers(default_headers).get(url, ssl_context: ssl_ctx).tap do |response|
    #     check_response(response)
    #   end
    #
    #   JSON.parse(res.body)
    # end
    #
    # def http_post_request
    #   res = HTTP.timeout(timeout).headers(default_headers).post(url, json: body, ssl_context: ssl_ctx).tap do |response|
    #     check_response(response)
    #   end
    #
    #   JSON.parse(res.body)
    # end
    #
    # def http_put_request
    #   res = HTTP.timeout(timeout).headers(default_headers).put(url, json: body, ssl_context: ssl_ctx).tap do |response|
    #     check_response(response)
    #   end
    #
    #   JSON.parse(res.body)
    # end
    #
    # def http_delete_request
    #   res = HTTP.timeout(timeout).headers(default_headers).delete(url, ssl_context: ssl_ctx).tap do |response|
    #     check_response(response)
    #   end
    #
    #   JSON.parse(res.body)
    # end
    #
    #
    # def check_response(response)
    #   raise ResponseError, response.status if response.status > 399
    # end
    #
    #
    # def ssl_ctx
    #   return @@ssl_ctx if defined? @@ssl_ctx
    #   @@ssl_ctx = OpenSSL::SSL::SSLContext.new.tap do |ctx|
    #     ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #   end
    # end
  end
end
