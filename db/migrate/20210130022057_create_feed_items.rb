# frozen_string_literal: true

class CreateFeedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :feed_items do |t|
      t.string :feed_item_type, null: false
      t.text :url, index: { unique: true }, null: false
      t.references :peer_info, null: false, foreign_key: true
      t.string :uid
      t.index [:peer_info_id, :uid], unique: true

      t.timestamps
    end
  end
end
