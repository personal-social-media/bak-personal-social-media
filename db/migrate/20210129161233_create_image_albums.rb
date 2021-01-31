class CreateImageAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :image_albums do |t|
      t.text :name, null: false
      t.text :description
      t.text :location_name

      t.timestamps
    end
  end
end
