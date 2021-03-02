class AddManualUploadToImageAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :image_albums, :manual_upload, :boolean, null: false, default: true
  end
end
