# frozen_string_literal: true

class AddUnreadMessagesCountToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :unread_messages_count, :bigint, null: false, default: 0
    add_column :profiles, :not_seen_notifications_count, :bigint, null: false, default: 0
    add_column :profiles, :last_seen_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
