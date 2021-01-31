# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  include PsmHelper
end
