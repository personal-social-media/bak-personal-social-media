# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.text :name, null: false
      t.string :username, null: false
      t.string :gender, null: false
      t.text :recover_key, null: false
      t.boolean :recover_key_saved, null: false, default: false

      t.timestamps
    end
  end
end
