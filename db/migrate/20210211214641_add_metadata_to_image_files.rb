class AddMetadataToImageFiles < ActiveRecord::Migration[6.1]
  def change
    %w(image_files video_files audio_files).each do |table|
      add_column table, :metadata, :text
    end
  end
end
