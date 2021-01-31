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
require "rails_helper"

RSpec.describe ImageAlbum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
