# frozen_string_literal: true

class UpdateCacheReaction < ActiveRecord::Migration[6.1]
  def change
    remove_column :cache_reactions, :subject_id
    add_reference :cache_reactions, :subject, polymorphic: true, index: { unique: true }, null: false
    add_column :cache_reactions, :remote_id, :integer, limit: 8, null: false
  end
end
