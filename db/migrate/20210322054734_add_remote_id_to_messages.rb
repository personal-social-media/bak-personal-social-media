class AddRemoteIdToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :remote_id, :bigint
    add_column :messages, :processing_status, :string, null: false, default: "processing"
    change_column :messages, :payload, :text, null: false, default: "{}"

    add_column :conversations, :messages_count, :bigint, null: false, default: 0
    add_column :conversations, :is_typing, :boolean, null: false, default: false
  end
end
