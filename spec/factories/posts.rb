# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  content       :text
#  like_count    :integer          default(0), not null
#  location_name :text
#  love_count    :integer          default(0), not null
#  mood          :string
#  privacy       :string           default("public_access"), not null
#  uid           :string           not null
#  wow_count     :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :post do
    content { "MyText" }
    mood { "MyString" }
    location_name { "MyText" }
  end
end
