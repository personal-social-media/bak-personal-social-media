class CreateUnblockRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :unblock_requests do |t|
      t.references :peer_info, null: false, index: true, foreign_key: true
      t.references :peer_info_requester, null: false, index: true, foreign_key: { to_table: :peer_infos }

      t.timestamps
    end
  end
end
