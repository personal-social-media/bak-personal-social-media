class RemoveMostRecent < ActiveRecord::Migration[6.1]
  def change
    remove_column :image_files, :most_recent
    remove_column :video_files, :most_recent
  end
end
