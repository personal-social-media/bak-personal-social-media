# frozen_string_literal: true

class FixRemoteCache < ActiveRecord::Migration[6.1]
  def change
    change_column :cache_reactions, :subject_id, :bigint, null: true
    change_column :cache_reactions, :subject_type, :string, null: true
    remove_index :cache_reactions, name: :index_cache_reactions_on_subject
    add_index :cache_reactions, %w(subject_id subject_type), unique: true, where: "subject_id IS NOT NULL AND subject_type IS NOT NULL"

    change_column :cache_comments, :subject_id, :bigint, null: true
    change_column :cache_comments, :subject_type, :string, null: true
    remove_index :cache_comments, name: :index_cache_comments_on_subject
    add_index :cache_comments, %w(subject_id subject_type), unique: true, where: "subject_id IS NOT NULL AND subject_type IS NOT NULL"

    change_column :verification_results, :subject_id, :bigint, null: true
    change_column :verification_results, :subject_type, :string, null: true
    remove_index :verification_results, name: :index_verification_results_on_subject_type_and_subject_id
    add_index :verification_results, %w(subject_id subject_type), unique: true, where: "subject_id IS NOT NULL AND subject_type IS NOT NULL"

    add_column :cache_comments, :payload_subject_type, :string, null: false
    add_column :cache_comments, :payload_subject_id, :string, null: false

    add_index :cache_comments, %w(payload_subject_id payload_subject_type), unique: true, name: :index_cache_comments_on_payload
  end
end
