# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :peer_info, null: false, foreign_key: true, index: true
      t.boolean :has_new_messages, null: false, default: false

      t.timestamps
    end
  end
end
