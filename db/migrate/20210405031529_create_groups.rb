class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :parameterized_name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
