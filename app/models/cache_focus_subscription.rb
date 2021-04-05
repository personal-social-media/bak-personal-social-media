# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_focus_subscriptions
#
#  id                   :bigint           not null, primary key
#  expires_at           :datetime         not null
#  payload_subject_type :string
#  token                :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  payload_subject_id   :string
#  peer_info_id         :bigint           not null
#
# Indexes
#
#  cache_focus_subscriptions_payload_idx            (payload_subject_type,payload_subject_id) UNIQUE
#  index_cache_focus_subscriptions_on_expires_at    (expires_at)
#  index_cache_focus_subscriptions_on_peer_info_id  (peer_info_id)
#  index_cache_focus_subscriptions_on_token         (token)
#
class CacheFocusSubscription < ApplicationRecord
  has_secure_token
  belongs_to :peer_info
  validates :payload_subject_id, presence: true, uniqueness: { scope: :payload_subject_type }
end
