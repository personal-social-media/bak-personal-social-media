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
class AudioFile < ApplicationRecord
end
