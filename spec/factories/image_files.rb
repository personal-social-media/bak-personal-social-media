# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id             :bigint           not null, primary key
#  description    :text
#  dominant_color :string
#  image_data     :string
#  location_name  :text
#  metadata       :text
#  private        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :image_file do
    image_data { "MyString" }
    dominant_color { "MyString" }
    location_name { "MyText" }
    description { "MyText" }
    private { false }
  end
end
