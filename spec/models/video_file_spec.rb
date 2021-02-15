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
require "rails_helper"

RSpec.describe VideoFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
