# frozen_string_literal: true

# == Schema Information
#
# Table name: gallery_elements
#
#  id             :bigint           not null, primary key
#  element_type   :string           not null
#  most_recent    :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  element_id     :bigint           not null
#  image_album_id :bigint           not null
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
class GalleryElement < ApplicationRecord
  include MostRecentConcern
  belongs_to :image_album, counter_cache: true
  belongs_to :element, polymorphic: true

  private
    def most_recent_query
      image_album.gallery_elements
    end

    def most_recent_limit
      11
    end
end
