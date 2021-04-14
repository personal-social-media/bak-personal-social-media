# frozen_string_literal: true

class CreateCacheComments < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_comments do |t|
      t.references :subject, polymorphic: true, null: false, index: true
      t.text :payload, null: false, default: "{}"
      t.integer :remote_id, null: false, limit: 8

      t.timestamps
    end

    add_column :posts, :comments_count, :integer, limit: 8, null: false, default: 0

    %w(like_count love_count wow_count).each do |column|
      %w(stories posts comments).each do |table|
        change_column table, column, :integer, limit: 8, null: false, default: 0
      end
    end
    add_column :comments, :signature, :text, null: false
  end
end
