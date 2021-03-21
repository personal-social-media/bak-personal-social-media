# frozen_string_literal: true

module HttpWorker
  class RetryTyphoeusRequest < ApplicationWorker
    class Error < Exception; end
    sidekiq_options retry: 4, queue: :http_retries
    sidekiq_retry_in do |count|
      case count
      when 1
        10.minutes.to_i
      when 2
        1.hour.to_i
      when 3
        1.day.to_i
      else
        7.days.to_i
      end
    end
    attr_reader :url, :http_method, :body, :headers, :request

    def perform(url, http_method, body, headers)
      @url = url
      @http_method = http_method
      @body = body
      @headers = headers
      @request = make_request
      check_request!
    end

    private
      def check_request!
        raise Error, "invalid status" if request.response.code > 399
      end

      def make_request
        hydra = Typhoeus::Hydra.hydra
        Typhoeus::Request.new(url, method: http_method, headers: headers, body: body).tap do |r|
          hydra.queue(r)
          hydra.run
        end
      end
  end
end
