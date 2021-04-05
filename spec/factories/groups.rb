# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id                      :bigint           not null, primary key
#  description             :string           not null
#  group_memberships_count :integer          default(0), not null
#  name                    :string           not null
#  parameterized_name      :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
FactoryBot.define do
  factory :group do
    name { "MyString" }
    description { "MyString" }
  end
end
