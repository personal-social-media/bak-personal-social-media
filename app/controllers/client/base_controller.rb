# frozen_string_literal: true

module Client
  class BaseController < ActionController::Base
    include SessionHelper
    before_action :require_current_user
  end
end
