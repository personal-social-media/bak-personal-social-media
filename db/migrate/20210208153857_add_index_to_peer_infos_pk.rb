# frozen_string_literal: true

class AddIndexToPeerInfosPk < ActiveRecord::Migration[6.1]
  def change
    add_index :peer_infos, :public_key, unique: true
  end
end
