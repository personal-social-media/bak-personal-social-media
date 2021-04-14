# frozen_string_literal: true

class CreatePreviousSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :previous_searches do |t|
      t.references :peer_info, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
