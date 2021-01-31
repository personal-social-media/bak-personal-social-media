# frozen_string_literal: true

# == Schema Information
#
# Table name: servers
#
#  id         :bigint           not null, primary key
#  ip         :string           not null
#  name       :string           not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :server do
    name { "MyString" }
    role { "MyString" }
    ip { "MyString" }
  end
end
