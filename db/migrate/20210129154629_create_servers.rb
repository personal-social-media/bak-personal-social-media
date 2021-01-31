class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.string :ip, null: false

      t.timestamps
    end
  end
end
