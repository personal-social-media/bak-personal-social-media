class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :payload
      t.string :message_type, null: false
      t.boolean :read, null: false, default: false
      t.references :conversation, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
