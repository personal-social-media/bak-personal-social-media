class CreateCacheGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_groups do |t|
      t.references :peer_info, null: false, foreign_key: true
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
