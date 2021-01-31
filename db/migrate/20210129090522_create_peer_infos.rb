class CreatePeerInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :peer_infos do |t|
      t.text :username, null: false
      t.string :ip, null: false
      t.text :public_key, null: false
      t.index [:username, :ip]

      t.timestamps
    end
  end
end
