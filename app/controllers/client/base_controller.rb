# frozen_string_literal: true

# internal use
module Client
  class BaseController < ActionController::Base
    include SessionHelper
    before_action :require_current_user
  end
end
