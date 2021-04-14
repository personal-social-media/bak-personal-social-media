# frozen_string_literal: true

class UpdateCacheComment < ActiveRecord::Migration[6.1]
  def up
    change_column :cache_comments, :remote_id, :bigint, null: true
    add_column :cache_comments, :parent_comment_id, :string
    add_index :cache_comments, :parent_comment_id
  end
end
