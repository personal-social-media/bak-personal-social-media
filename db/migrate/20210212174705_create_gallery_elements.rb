class CreateGalleryElements < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_elements do |t|
      t.references :image_album, null: false, foreign_key: true, index: true
      t.references :element, polymorphic: true, null: false, index: true
      t.boolean :most_recent

      t.timestamps
    end

    add_column :image_albums, :gallery_elements_count, :integer, null: false, default: 0

    ImageFile.all.includes(:image_album).each do |file|
      GalleryElement.create(image_album: file.image_album, element: file)
    end

    remove_column :image_albums, :image_files_count
    remove_column :image_albums, :video_files_count
    remove_column :image_files, :image_album_id
    remove_column :video_files, :image_album_id
  end
end
