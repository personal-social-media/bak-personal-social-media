class CreateProofReactionsTests < ActiveRecord::Migration[6.1]
  def change
    create_table :proof_reactions_tests do |t|
      t.references :subject, polymorphic: true, null: false, index: true
      t.text :result, null: false, default: "{}"

      t.timestamps
    end
  end
end
