class AddRecoveryKeyPlainToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :recovery_key_plain, :text
    remove_column :profiles, :recovery_key_saved
  end
end
