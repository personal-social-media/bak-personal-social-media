# frozen_string_literal: true

class AddSignatureToPeerInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :peer_infos, :signature, :text, null: false, default: ""
  end
end
