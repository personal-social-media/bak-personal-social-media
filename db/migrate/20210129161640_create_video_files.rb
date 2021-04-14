# frozen_string_literal: true

class CreateVideoFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :video_files do |t|
      t.string :cover_image_data
      t.string :dominant_color
      t.integer :duration_seconds
      t.text :location_name
      t.text :video_data
      t.boolean :private
      t.references :image_album, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
