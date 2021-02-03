class AddAboutToProfile < ActiveRecord::Migration[6.1]
  def change
    %i(profiles peer_infos).each do |table|
      add_column table, :about, :text
      add_column table, :country_code, :string
      add_column table, :city_name, :text
    end

    add_index :peer_infos, :country_code
    add_index :peer_infos, :city_name
  end
end
