# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id            :bigint           not null, primary key
#  like_count    :integer          default(0), not null
#  location_name :text
#  love_count    :integer          default(0), not null
#  privacy       :string           default("public_access"), not null
#  uid           :string           not null
#  wow_count     :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Story < ApplicationRecord
  include UidConcern
  include PrivacyConcern
end
