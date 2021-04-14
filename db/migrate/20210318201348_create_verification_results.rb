# frozen_string_literal: true

class CreateVerificationResults < ActiveRecord::Migration[6.1]
  def change
    create_table :verification_results do |t|
      t.references :subject, polymorphic: true, null: false, index: true
      t.text :result, null: false, default: "{}"
      t.string :status, null: false, default: :running
      t.integer :percentage_status, null: false, default: 0

      t.timestamps
    end
  end
end
