# frozen_string_literal: true

module Api
  class BaseController < ActionController::Base
    include NodeVerifyRequest
    skip_before_action :verify_authenticity_token
  end
end
