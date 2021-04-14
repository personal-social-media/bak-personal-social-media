# frozen_string_literal: true

class UpdateStatusForFiles < ActiveRecord::Migration[6.1]
  def change
    change_column :attached_files, :processing_status, :string, default: :processing
    change_column :gallery_elements, :processing_status, :string, default: :processing
  end
end
