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
class Comment < ApplicationRecord
  belongs_to :peer_info
  belongs_to :parent_comment, class_name: "Comment", counter_cache: true, optional: true
  belongs_to :subject, polymorphic: true, counter_cache: true
  validate :validate_signature, if: -> { payload_changed? || signature_changed? }
  validate :validate_parent, on: :create

  serialize :payload, JSON

  private
    def validate_signature
      errors.add(:payload, :invalid, message: "Invalid payload") unless PeerInfoService::ValidateSignedContent.new(peer_info, payload.to_json, signature, decode: true).call!
    end

    def validate_parent
      return if parent_comment.blank? || parent_comment.parent_comment_id.blank?
      errors.add(:parent_comment_id, :invalid, message: "too deep")
    end
end
