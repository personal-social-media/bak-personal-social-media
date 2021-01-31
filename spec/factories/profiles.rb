# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id                :bigint           not null, primary key
#  gender            :string           not null
#  name              :text             not null
#  recover_key       :text             not null
#  recover_key_saved :boolean          default(FALSE), not null
#  username          :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :profile do
    name { "MyText" }
    username { "MyString" }
    gender { "MyString" }
  end
end
