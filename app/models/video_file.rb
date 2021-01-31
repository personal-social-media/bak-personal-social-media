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
#  private          :boolean
#  video_data       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  image_album_id   :bigint           not null
#
# Indexes
#
#  index_video_files_on_image_album_id  (image_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (image_album_id => image_albums.id)
#
class VideoFile < ApplicationRecord
  belongs_to :album
end
