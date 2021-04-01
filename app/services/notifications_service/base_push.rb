# frozen_string_literal: true

module NotificationsService
  class BasePush
    def current_user
      @@current_user ||= Profile.first
    end
  end
end
