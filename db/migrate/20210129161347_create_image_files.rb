# frozen_string_literal: true

class CreateImageFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :image_files do |t|
      t.string :image_data
      t.string :dominant_color
      t.text :location_name
      t.text :description
      t.boolean :private, null: false, default: true
      t.references :image_album, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
