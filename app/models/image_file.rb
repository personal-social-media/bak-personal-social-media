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
#  most_recent    :boolean          default(FALSE), not null
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
class ImageFile < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include MostRecentConcern
  belongs_to :image_album
  has_many :attached_files, dependent: :delete_all, as: :attachment

  private
    def most_recent_query
      image_album.image_files
    end

    def most_recent_limit
      5
    end
end
