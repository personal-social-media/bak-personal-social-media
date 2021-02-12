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
#  most_recent    :boolean          default(FALSE), not null
#  private        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ImageFile < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include PgSearch::Model
  include MostRecentConcern
  belongs_to :image_album, counter_cache: true
  has_many :gallery_elements, dependent: :delete_all, as: :element
  has_many :attached_files, dependent: :delete_all, as: :attachment
  serialize :metadata, JSON
  multisearchable against: [:location_name], if: ->(r) { r.location_name.present? }

  private
    def most_recent_query
      image_album.image_files
    end

    def most_recent_limit
      11
    end
end
