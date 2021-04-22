# frozen_string_literal: true

module NotificationsService
  class NotificationImage
    include AssetsService::AssetsUrl
    def initialize(notification)
      @notification = notification
    end

    def call!
      image_url("logos/psm.svg")
    end
  end
end
