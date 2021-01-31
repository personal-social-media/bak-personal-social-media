# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                 :bigint           not null, primary key
#  like_count         :integer          default(0), not null
#  love_count         :integer          default(0), not null
#  payload            :text
#  sub_comments_count :integer          default(0), not null
#  subject_type       :string           not null
#  uid                :string           not null
#  wow_count          :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_comment_id  :bigint
#  peer_info_id       :bigint
#  subject_id         :bigint           not null
#
# Indexes
#
#  index_comments_on_parent_comment_id  (parent_comment_id)
#  index_comments_on_peer_info_id       (peer_info_id)
#  index_comments_on_subject            (subject_type,subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_comment_id => comments.id)
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
FactoryBot.define do
  factory :comment do
    payload { "MyText" }
    peer_info { nil }
    parent_comment { nil }
    subject { nil }
  end
end
