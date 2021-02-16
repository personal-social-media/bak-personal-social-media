class AddColumnServerLastSeenAtToPeerInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :peer_infos, :server_last_seen, :datetime
  end
end
