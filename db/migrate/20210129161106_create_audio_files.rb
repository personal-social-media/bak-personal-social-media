# frozen_string_literal: true

class CreateAudioFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :audio_files do |t|
      t.text :title, null: false
      t.text :description
      t.text :artist
      t.text :album
      t.text :file_data

      t.timestamps
    end
  end
end
