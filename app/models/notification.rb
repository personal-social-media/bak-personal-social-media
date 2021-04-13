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
class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  str_enum :notification_type, %i(profile_welcome new_post new_friendship_request reaction new_message)
  serialize :metadata, JSON
  unless Rails.env.test?
    after_commit :push_notification, on: :create
    before_save :increment_not_seen_notifications_count!, if: -> { !seen? }
  end

  def push_notification
    NotificationsChannel::PushNotification.new(self).call!
  end

  def increment_not_seen_notifications_count!
    NotificationsService::IncrementNotSeen.new.call!
  end
end
