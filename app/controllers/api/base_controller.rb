# frozen_string_literal: true

# external use
module Api
  class BaseController < ActionController::Base
    include NodeVerifyRequest
    skip_before_action :verify_authenticity_token
    before_action :skip_cookies


    private
      def skip_cookies
        request.session_options[:skip] = true
      end
  end
end
