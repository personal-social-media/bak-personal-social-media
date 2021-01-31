class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.references :peer_info, foreign_key: true
      t.string :reaction_type, null: false
      t.references :subject, polymorphic: true, null: false
      t.index [:peer_info_id, :subject_id], unique: true

      t.timestamps
    end
  end
end
