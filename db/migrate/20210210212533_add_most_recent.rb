class AddMostRecent < ActiveRecord::Migration[6.1]
  def change
    %w(image_files video_files).each do |table|
      add_column table, :most_recent, :boolean, default: false, null: false
    end
  end
end
