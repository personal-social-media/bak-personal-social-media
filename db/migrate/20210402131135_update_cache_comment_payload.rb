class UpdateCacheCommentPayload < ActiveRecord::Migration[6.1]
  def change
    add_column :cache_comments, :signature, :text
  end
end
