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
#  metadata       :text
#  private        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ImageFile < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include PgSearch::Model
  has_many :gallery_elements, dependent: :delete_all, as: :element
  has_many :attached_files, dependent: :delete_all, as: :attachment
  serialize :metadata, JSON
  multisearchable against: [:location_name], if: ->(r) { r.location_name.present? }
end
