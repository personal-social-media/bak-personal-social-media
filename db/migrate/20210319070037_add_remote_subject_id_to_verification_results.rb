# frozen_string_literal: true

class AddRemoteSubjectIdToVerificationResults < ActiveRecord::Migration[6.1]
  def change
    add_column :verification_results, :remote_id, :string, null: false
    add_column :verification_results, :remote_type, :string, null: false

    add_index :verification_results, %i(remote_id remote_type), unique: true

    remove_index :verification_results, %i(subject_type subject_id)
    add_index :verification_results, %i(subject_type subject_id), unique: true
  end
end
