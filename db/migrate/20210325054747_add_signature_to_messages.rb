# frozen_string_literal: true

class AddSignatureToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :signature, :text
    add_column :messages, :message_owner, :string, null: false, default: ""
    add_index :messages, :remote_id
  end
end
