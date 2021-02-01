# frozen_string_literal: true

module Api
  class BaseController < ActionController::Base
    include NodeVerifyRequest
  end
end
