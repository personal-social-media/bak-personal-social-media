# frozen_string_literal: true

class RemoveUid < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :uid
    FeedItem.destroy_all

    add_column :feed_items, :feed_item_id, :bigint, null: false

    remove_index :feed_items, name: :index_feed_items_on_peer_info_id_and_uid
    add_index :feed_items, :uid, unique: true
    add_index :feed_items, %i(feed_item_type feed_item_id peer_info_id), unique: true, name: "feed_items_index_feed_item"
  end
end
