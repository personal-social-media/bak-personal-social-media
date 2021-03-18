class AddReactionsToComments < ActiveRecord::Migration[6.1]
  def change
    %w(like_count love_count wow_count).each do |column|
      add_column :cache_comments, column, :integer, null: false, default: 0
    end

    add_column :posts, :signature, :text, null: false, default: ""
  end
end
