# frozen_string_literal: true

# == Schema Information
#
# Table name: image_albums
#
#  id                :bigint           not null, primary key
#  description       :text
#  image_files_count :integer          default(0), not null
#  location_name     :text
#  name              :text             not null
#  privacy           :string           default("public_access"), not null
#  video_files_count :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :image_album do
    name { "MyText" }
    description { "MyText" }
    location_name { "MyText" }
  end
end
