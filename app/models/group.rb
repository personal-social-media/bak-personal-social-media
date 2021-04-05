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
class Group < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :group_memberships, dependent: :destroy
end
