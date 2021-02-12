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
#  private          :boolean
#  real_created_at  :datetime
#  real_file_name   :string
#  video_data       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class VideoFile < ApplicationRecord
  has_many :gallery_elements, dependent: :delete_all, as: :element
  has_many :attached_files, dependent: :delete_all, as: :attachment
end
