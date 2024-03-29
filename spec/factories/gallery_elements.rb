# frozen_string_literal: true

# == Schema Information
#
# Table name: gallery_elements
#
#  id                :bigint           not null, primary key
#  element_type      :string           not null
#  most_recent       :boolean
#  processing_status :string           default("processing")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  element_id        :bigint           not null
#  image_album_id    :bigint           not null
#
# Indexes
#
#  index_gallery_elements_on_element         (element_type,element_id)
#  index_gallery_elements_on_image_album_id  (image_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (image_album_id => image_albums.id)
#
FactoryBot.define do
  factory :gallery_element do
    before(:create) do |r|
      r.image_album ||= create(:image_album)
      r.element ||= create(:image_file)
    end
  end
end
