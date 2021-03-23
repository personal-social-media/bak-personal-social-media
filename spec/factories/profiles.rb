# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id                  :bigint           not null, primary key
#  about               :text
#  city_name           :text
#  country_code        :string
#  gender              :string           not null
#  name                :text             not null
#  recovery_key_digest :text
#  recovery_key_plain  :text
#  username            :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :profile do
    name { "Name" }
    username { "username" }
    gender { :female }
    country_code { "US" }
    recovery_key { "UID-#{SecureRandom.hex}" }
  end
end
