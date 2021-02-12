class AddRealFileName < ActiveRecord::Migration[6.1]
  def change
    %i(image_files video_files).each do |table|
      add_column table, :real_file_name, :string
      add_column table, :real_created_at, :datetime
    end
  end
end
