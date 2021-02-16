class AddProcessingStatusToImageFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :attached_files, :processing_status, :string
    add_column :gallery_elements, :processing_status, :string

    AttachedFile.update_all(processing_status: :processed)
    GalleryElement.update_all(processing_status: :processed)
  end
end
