# frozen_string_literal: true

class AddPayloadSubjectTypeToCacheReaction < ActiveRecord::Migration[6.1]
  def change
    add_column :cache_reactions, :payload_subject_type, :string, null: false, default: ""
    add_column :cache_reactions, :payload_subject_id, :string, null: false, default: ""

    add_index :cache_reactions, %w(payload_subject_type payload_subject_id), unique: true, name: "payload_index"
  end
end
