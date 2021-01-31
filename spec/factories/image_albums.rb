# frozen_string_literal: true

# == Schema Information
#
# Table name: image_albums
#
#  id            :bigint           not null, primary key
#  description   :text
#  location_name :text
#  name          :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :image_album do
    name { "MyText" }
    description { "MyText" }
    location_name { "MyText" }
  end
end
