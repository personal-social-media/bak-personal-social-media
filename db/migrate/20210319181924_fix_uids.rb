class FixUids < ActiveRecord::Migration[6.1]
  def change
    %w(feed_items comments stories posts).each do |table|
      change_column table, :uid, :text, limit: 600, null: false
    end

    add_index :comments, :uid, unique: true
    add_index :posts, :uid, unique: true
    add_index :stories, :uid, unique: true
  end
end
