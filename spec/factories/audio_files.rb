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
FactoryBot.define do
  factory :audio_file do
    title { "MyText" }
    description { "MyText" }
    artist { "MyText" }
    album { "MyText" }
    file_data { "MyText" }
  end
end
