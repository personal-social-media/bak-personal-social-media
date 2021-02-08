# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  include PsmHelper
  include StimulusHelper
  helper_method :current_user, :signed_in?
end
