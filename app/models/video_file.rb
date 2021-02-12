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
#  metadata         :text
#  most_recent      :boolean          default(FALSE), not null
#  private          :boolean
#  video_data       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class VideoFile < ApplicationRecord
  include MostRecentConcern
  belongs_to :image_album, counter_cache: true

  private
    def most_recent_query
      image_album.video_files
    end

    def most_recent_limit
      5
    end
end
