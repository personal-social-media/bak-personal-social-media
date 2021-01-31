# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  content       :text
#  like_count    :integer          default(0), not null
#  location_name :text
#  love_count    :integer          default(0), not null
#  mood          :string
#  uid           :string           not null
#  wow_count     :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
