class CreateGroupMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :group_memberships do |t|
      t.references :group, null: false, foreign_key: true
      t.string :role
      t.references :peer_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
