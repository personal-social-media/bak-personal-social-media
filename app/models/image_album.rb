# frozen_string_literal: true

# == Schema Information
#
# Table name: image_albums
#
#  id                :bigint           not null, primary key
#  description       :text
#  image_files_count :integer          default(0), not null
#  location_name     :text
#  name              :text             not null
#  privacy           :string           default("public_access"), not null
#  video_files_count :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class ImageAlbum < ApplicationRecord
  include PrivacyConcern
  include PgSearch::Model
  has_many :image_files, dependent: :destroy
  has_many :video_files, dependent: :destroy

  multisearchable against: [:name, :location_name, :description]
end
