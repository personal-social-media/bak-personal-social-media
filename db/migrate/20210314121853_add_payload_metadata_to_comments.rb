# frozen_string_literal: true

class AddPayloadMetadataToComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :payload, :text, null: false, default: "{}"
  end
end
