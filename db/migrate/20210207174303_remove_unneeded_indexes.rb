class RemoveUnneededIndexes < ActiveRecord::Migration[6.1]
  def change
    remove_index :feed_items, name: "index_feed_items_on_peer_info_id", column: :peer_info_id
    remove_index :reactions, name: "index_reactions_on_peer_info_id", column: :peer_info_id
  end
end
