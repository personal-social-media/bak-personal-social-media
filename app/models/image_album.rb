# frozen_string_literal: true

# == Schema Information
#
# Table name: image_albums
#
#  id            :bigint           not null, primary key
#  description   :text
#  location_name :text
#  name          :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ImageAlbum < ApplicationRecord
  has_many :image_files, dependent: :destroy
  has_many :video_files, dependent: :destroy
end
