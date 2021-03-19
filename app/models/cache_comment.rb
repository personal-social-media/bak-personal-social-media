# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_comments
#
#  id                   :bigint           not null, primary key
#  like_count           :integer          default(0), not null
#  love_count           :integer          default(0), not null
#  payload              :text             default("{}"), not null
#  payload_subject_type :string           not null
#  subject_type         :string
#  wow_count            :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  payload_subject_id   :string           not null
#  peer_info_id         :bigint           not null
#  remote_id            :bigint           not null
#  subject_id           :bigint
#
# Indexes
#
#  index_cache_comments_on_payload                      (payload_subject_id,payload_subject_type) UNIQUE
#  index_cache_comments_on_peer_info_id                 (peer_info_id)
#  index_cache_comments_on_subject_id_and_subject_type  (subject_id,subject_type) UNIQUE WHERE ((subject_id IS NOT NULL) AND (subject_type IS NOT NULL))
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
class CacheComment < ApplicationRecord
  belongs_to :subject, polymorphic: true, optional: true
  belongs_to :peer_info
  validates :payload_subject_type, presence: true
  validates :payload_subject_id, presence: true, uniqueness: { scope: :payload_subject_type }
end
