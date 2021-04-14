# frozen_string_literal: true

class CreateGroupMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :group_memberships do |t|
      t.references :group, null: false, foreign_key: true, index: true
      t.string :role, null: false
      t.references :peer_info, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
