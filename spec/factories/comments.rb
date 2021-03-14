# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                 :bigint           not null, primary key
#  like_count         :bigint           default(0), not null
#  love_count         :bigint           default(0), not null
#  payload            :text             default({}), not null
#  signature          :text             not null
#  sub_comments_count :integer          default(0), not null
#  subject_type       :string           not null
#  uid                :string           not null
#  wow_count          :bigint           default(0), not null
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
    before(:create) do |r|
      r.peer_info ||= create(:peer_info)
      r.subject ||= create(:post)
    end

    payload do
      {
        message: "test",
        subject_id: subject_id,
        subject_type: subject_type,
        parent_comment_id: parent_comment_id,
        images: [],
        videos: []
      }
    end

    signature do
      SignaturesService::Sign.new(payload.to_json).call!
    end
  end
end
