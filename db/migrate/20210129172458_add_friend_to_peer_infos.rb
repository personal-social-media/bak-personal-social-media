# frozen_string_literal: true

class AddFriendToPeerInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :peer_infos, :friend, :boolean, null: false, default: false
    add_column :peer_infos, :avatar_url, :text
    add_column :peer_infos, :friend_ship_status, :string
  end
end
