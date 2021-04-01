# frozen_string_literal: true

class NotificationsChannel
  class PushNotification < NotificationsService::BasePush
    attr_reader :notification

    def initialize(notification)
      @notification = notification
    end

    def call!
      push(NotificationPresenter.new(notification).render)
    end

    def push(data)
      ActionCable.server.broadcast("notifications", { notification: data })
    end
  end
end
