# frozen_string_literal: true

module MessagesService
  class IncrementUnread
    def call!
      profile.increment!(:unread_messages_count)
    end

    def profile
      @profile ||= Profile.first
    end
  end
end
