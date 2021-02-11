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
#  image_album_id :bigint           not null
#
# Indexes
#
#  index_image_files_on_image_album_id  (image_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (image_album_id => image_albums.id)
#
require "rails_helper"

RSpec.describe ImageFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
