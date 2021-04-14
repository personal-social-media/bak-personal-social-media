# frozen_string_literal: true

class AddPrivacyToPosts < ActiveRecord::Migration[6.1]
  def change
    %i(posts stories image_albums).each do |table|
      add_column table, :privacy, :string, null: false, default: :public_access
    end
  end
end
