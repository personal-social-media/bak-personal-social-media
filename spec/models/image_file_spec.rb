# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id              :bigint           not null, primary key
#  description     :text
#  dominant_color  :string
#  image_data      :string
#  location_name   :text
#  md5_checksum    :string
#  metadata        :text
#  private         :boolean          default(TRUE), not null
#  real_created_at :datetime
#  real_file_name  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe ImageFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
