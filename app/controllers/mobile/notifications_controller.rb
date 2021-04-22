# frozen_string_literal: true

module Mobile
  class NotificationsController < ApplicationController
    before_action :require_current_user
    layout "mobile"

    def index
      @title = "Notifications"
    end
  end
end
