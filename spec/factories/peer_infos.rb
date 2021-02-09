# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_infos
#
#  id                 :bigint           not null, primary key
#  about              :text
#  avatars            :text
#  city_name          :text
#  country_code       :string
#  friend_ship_status :string
#  ip                 :string           not null
#  name               :text
#  public_key         :text             not null
#  username           :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_peer_infos_on_city_name        (city_name)
#  index_peer_infos_on_country_code     (country_code)
#  index_peer_infos_on_name             (name) USING gin
#  index_peer_infos_on_public_key       (public_key) UNIQUE
#  index_peer_infos_on_username_and_ip  (username,ip)
#
FactoryBot.define do
  factory :peer_info do
    sequence :username do |n|
      "username-#{n}"
    end
    sequence :name do |n|
      "name-#{n}"
    end
    ip { "0.0.0.0" }
    public_key { SecureRandom.hex }
    country_code { "US" }
  end
end
