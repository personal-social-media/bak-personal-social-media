# frozen_string_literal: true

class CreateCacheReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_reactions do |t|
      t.string :subject_id, null: false, index: true
      t.string :reaction_type, null: false

      t.timestamps
    end
  end
end
