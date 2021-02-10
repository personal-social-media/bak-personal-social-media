class AddIndexToPreviousSearches < ActiveRecord::Migration[6.1]
  def change
    add_index :previous_searches, :created_at
  end
end
