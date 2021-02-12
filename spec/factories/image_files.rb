# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id              :bigint           not null, primary key
#  description     :text
#  dominant_color  :string
#  image_data      :string
#  location_name   :text
#  metadata        :text
#  private         :boolean          default(TRUE), not null
#  real_created_at :datetime
#  real_file_name  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :image_file do
    image do
      new_image_path = "/tmp/image-#{SecureRandom.hex}.png"
      `cp #{Rails.root.join("spec/support/resources/image.png")} #{new_image_path}`
      File.open(new_image_path)
    end
    dominant_color { "MyString" }
    location_name { "MyText" }
    description { "MyText" }
    private { false }
  end
end
