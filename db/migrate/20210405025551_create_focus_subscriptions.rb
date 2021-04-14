# frozen_string_literal: true

class CreateFocusSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :focus_subscriptions do |t|
      t.references :subject, null: false, index: true, polymorphic: true
      t.references :peer_info, null: false, index: true
      t.datetime :expires_at, null: false, index: true
      t.string :token, null: false

      t.timestamps
    end
  end
end
