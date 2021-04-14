# frozen_string_literal: true

class AddPeerInfosToCaches < ActiveRecord::Migration[6.1]
  def change
    %w(cache_reactions cache_comments verification_results).each do |table|
      add_reference table, :peer_info, null: false, index: true, foreign_key: true
    end
  end
end
