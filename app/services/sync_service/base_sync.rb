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
  end
end
