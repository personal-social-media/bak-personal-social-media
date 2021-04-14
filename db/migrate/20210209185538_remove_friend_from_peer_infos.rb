# frozen_string_literal: true

class RemoveFriendFromPeerInfos < ActiveRecord::Migration[6.1]
  def change
    remove_column :peer_infos, :friend
  end
end
