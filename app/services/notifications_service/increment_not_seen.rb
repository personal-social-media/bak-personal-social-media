# frozen_string_literal: true

module NotificationsService
  class IncrementNotSeen
    def call!
      profile.increment!(:not_seen_notifications_count)
    end

    def profile
      @profile ||= Profile.first
    end
  end
end
