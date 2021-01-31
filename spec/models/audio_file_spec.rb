# frozen_string_literal: true

# == Schema Information
#
# Table name: audio_files
#
#  id          :bigint           not null, primary key
#  album       :text
#  artist      :text
#  description :text
#  file_data   :text
#  title       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe AudioFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
