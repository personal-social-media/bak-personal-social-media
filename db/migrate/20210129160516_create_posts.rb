class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :mood
      t.text :location_name

      t.timestamps
    end
  end
end
