# frozen_string_literal: true

class RemoveProofReactions < ActiveRecord::Migration[6.1]
  def change
    drop_table :proof_reactions_tests if table_exists?(:proof_reactions_tests)
  end
end
