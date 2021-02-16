# frozen_string_literal: true

# internal use

class HomeController < ApplicationController
  before_action :require_current_user

  def index
    @title = "Home"
  end
end
