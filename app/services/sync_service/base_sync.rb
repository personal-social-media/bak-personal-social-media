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

    def json_headers
      {
        "Accept": "application/json",
        "Content-Type": "application/json"
      }
    end

    def check_response(request)
      if request.response.code > 399
        if Rails.env.production?
          options = request.options
          HttpWorker::RetryTyphoeusRequest.perform_in(request.url, 10.minutes, options[:method], options[:body], options[:headers])
        else
          raise ResponseError, "#{request.response.code} #{request.url}"
        end
      end
    end
  end
end
