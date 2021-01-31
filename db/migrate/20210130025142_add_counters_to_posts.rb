class AddCountersToPosts < ActiveRecord::Migration[6.1]
  def change
    %i(comments posts stories).each do |table|
      %i(like love wow).each do |type|
        add_column table, "#{type}_count", :integer, null: false, default: 0
      end
      add_column table, :uid, :string, null: false
    end
  end
end
