# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  metadata          :text             default({}), not null
#  notification_type :string           not null
#  seen              :boolean          default(FALSE), not null
#  subject_type      :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#
# Indexes
#
#  index_notifications_on_subject     (subject_type,subject_id)
#  index_notifications_on_updated_at  (updated_at)
#
require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "#push_notification" do
    let(:notification) { create(:notification) }

    it "pushes to action cable" do
      allow_any_instance_of(NotificationsChannel::PushNotification).to receive(:push).at_least(:once)
      notification.push_notification
    end
  end
end
