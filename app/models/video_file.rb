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
class VideoFile < ApplicationRecord
  IMAGES_EXTENSIONS = %w(mp4 webm).freeze
  include VideoUploader::Attachment(:video)
  has_many :gallery_elements, dependent: :destroy, as: :element
  has_many :attached_files, dependent: :destroy, as: :attachment

  serialize :metadata, JSON
end
