class CreateCacheFocusSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_focus_subscriptions do |t|
      t.references :peer_info, null: false, index: true
      t.string :payload_subject_type
      t.string :payload_subject_id
      t.string :token, null: false, index: :unique
      t.datetime :expires_at, null: false, index: true

      t.index %i(payload_subject_type payload_subject_id), unique: true, name: :cache_focus_subscriptions_payload_idx
      t.timestamps
    end
  end
end
