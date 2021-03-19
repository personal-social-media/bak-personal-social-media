class FixUids2 < ActiveRecord::Migration[6.1]
  def change
    %w(feed_items comments stories posts).each do |table|
      change_column table, :uid, :text, null: false
    end
  end
end
