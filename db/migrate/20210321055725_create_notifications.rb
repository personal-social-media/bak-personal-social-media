class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :notification_type, null: false
      t.boolean :seen, null: false, default: false
      t.text :metadata, null: false, default: "{}"
      t.references :subject, polymorphic: true, null: false, index: true

      t.timestamps
      t.index :updated_at
    end
  end
end
