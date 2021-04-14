# frozen_string_literal: true

class AddImageFilesCountToImageAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :image_albums, :image_files_count, :integer, null: false, default: 0
    add_column :image_albums, :video_files_count, :integer, null: false, default: 0
  end
end
