class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :payload
      t.references :peer_info, foreign_key: true
      t.references :parent_comment, foreign_key: {to_table: :comments}, index: true
      t.references :subject, polymorphic: true, null: false, index: true
      t.integer :sub_comments_count, null: false, default: 0

      t.timestamps
    end
  end
end
