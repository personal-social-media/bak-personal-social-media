# frozen_string_literal: true

# == Schema Information
#
# Table name: image_albums
#
#  id                     :bigint           not null, primary key
#  description            :text
#  gallery_elements_count :integer          default(0), not null
#  location_name          :text
#  name                   :text             not null
#  privacy                :string           default("public_access"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class ImageAlbum < ApplicationRecord
  include PrivacyConcern
  include PgSearch::Model
  has_many :gallery_elements, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, allow_blank: true, length: { maximum: 2000 }
  validates :privacy, presence: true

  multisearchable against: [:name, :location_name, :description]
end
