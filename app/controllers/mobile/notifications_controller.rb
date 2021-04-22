# frozen_string_literal: true

module Mobile
  class NotificationsController < ApplicationController
    before_action :require_current_user
    layout "mobile"

    def index
    end
  end
end
