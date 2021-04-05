# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :bigint           default(0), not null
#  content        :text
#  like_count     :bigint           default(0), not null
#  location_name  :text
#  love_count     :bigint           default(0), not null
#  mood           :string
#  privacy        :string           default("public_access"), not null
#  signature      :text             default(""), not null
#  uid            :text             not null
#  wow_count      :bigint           default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_id       :bigint
#
# Indexes
#
#  index_posts_on_group_id  (group_id)
#  index_posts_on_uid       (uid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
FactoryBot.define do
  factory :post do
    content { "MyText" }
    mood { "MyString" }
    location_name { "MyText" }
  end
end
