class AddNameToPeerInfo < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pg_trgm'
    add_column :peer_infos, :name, :text

    add_index :peer_infos, :name, opclass: :gin_trgm_ops, using: :gin

    remove_column :peer_infos, :avatar_url

    add_column :peer_infos, :avatars, :text
  end
end
