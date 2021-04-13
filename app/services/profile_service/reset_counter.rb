# frozen_string_literal: true

module ProfileService
  class ResetCounter
    class ResetError < Exception; end
    PERMITTED_COUNTERS = %w(not_seen_notifications_count unread_messages_count)

    attr_reader :profile, :counter
    def initialize(profile, params)
      @profile = profile
      @counter = params[:counter]
    end

    def call!
      profile.update_column(permitted_counter, 0)
    end

    def permitted_counter
      unless PERMITTED_COUNTERS.include?(counter)
        raise ResetError, "invalid counter"
      end

      counter
    end
  end
end
