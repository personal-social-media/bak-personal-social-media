# frozen_string_literal: true

class AddMd5ToImageFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :image_files, :md5_checksum, :string
    add_column :video_files, :md5_checksum, :string
  end
end
