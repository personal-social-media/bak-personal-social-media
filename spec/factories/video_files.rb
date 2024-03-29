# frozen_string_literal: true

# == Schema Information
#
# Table name: video_files
#
#  id               :bigint           not null, primary key
#  cover_image_data :string
#  dominant_color   :string
#  duration_seconds :integer
#  location_name    :text
#  md5_checksum     :string
#  metadata         :text
#  private          :boolean
#  real_created_at  :datetime
#  real_file_name   :string
#  video_data       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :video_file do
    cover_image_data { "MyString" }
    dominant_color { "MyString" }
    location_name { "MyText" }
    video_data { "MyText" }
    private { false }
    album { nil }
  end
end
