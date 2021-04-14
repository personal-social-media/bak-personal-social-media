# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.boolean :ui_sidebar_opened, null: false, default: true

      t.timestamps
    end

    Setting.create!
  end
end
