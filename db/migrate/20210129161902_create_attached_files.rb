# frozen_string_literal: true

class CreateAttachedFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :attached_files do |t|
      t.references :attachment, polymorphic: true, null: false, index: true
      t.references :subject, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
