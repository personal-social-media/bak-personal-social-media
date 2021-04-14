# frozen_string_literal: true

class Pghero < ActiveRecord::Migration[6.1]
  def change
    enable_extension "pg_stat_statements"
  end
end
