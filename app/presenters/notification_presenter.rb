# frozen_string_literal: true

class NotificationPresenter
  attr_reader :notification
  def initialize(notification)
    @notification = notification
  end

  def render
    notification.as_json(only: %i(id metadata notification_type seen subject_type subject_id))
  end
end
