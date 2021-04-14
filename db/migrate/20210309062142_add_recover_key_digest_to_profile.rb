# frozen_string_literal: true

class AddRecoverKeyDigestToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :recovery_key_digest, :text

    Profile.all.each do |profile|
      profile.update!(recovery_key: profile.recover_key)
    end

    rename_column :profiles, :recover_key_saved, :recovery_key_saved

    remove_column :profiles, :recover_key
  end
end
