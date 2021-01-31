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
#  private        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image_album_id :bigint           not null
#
# Indexes
#
#  index_image_files_on_image_album_id  (image_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (image_album_id => image_albums.id)
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
