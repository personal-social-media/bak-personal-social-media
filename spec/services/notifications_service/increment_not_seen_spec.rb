# frozen_string_literal: true

require "rails_helper"

describe NotificationsService::IncrementNotSeen do
  describe "Notification#increment_not_seen_notifications_count!" do
    let(:notification) { create(:notification, subject: profile) }
    let(:profile) { create(:profile) }

    subject do
      notification.increment_not_seen_notifications_count!
      profile.reload
    end

    it "changes not_seen_notifications_count" do
      profile

      expect do
        subject
      end.to change { profile.not_seen_notifications_count }.to 1
    end
  end
end
