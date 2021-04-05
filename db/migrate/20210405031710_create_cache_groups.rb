class CreateCacheGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_groups do |t|
      t.references :peer_info, null: false, foreign_key: true, index: true
      t.bigint :remote_id, null: false
      t.string :name, null: false
      t.string :role, null: false

      t.timestamps
    end

    add_reference :posts, :group, foreign_key: true, index: true
    add_column :groups, :group_memberships_count, :integer, null: false, default: 0
  end
end
