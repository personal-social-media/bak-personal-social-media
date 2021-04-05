# frozen_string_literal: true

# == Schema Information
#
# Table name: focus_subscriptions
#
#  id           :bigint           not null, primary key
#  expires_at   :datetime         not null
#  subject_type :string           not null
#  token        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  peer_info_id :bigint           not null
#  subject_id   :bigint           not null
#
# Indexes
#
#  index_focus_subscriptions_on_expires_at    (expires_at)
#  index_focus_subscriptions_on_peer_info_id  (peer_info_id)
#  index_focus_subscriptions_on_subject       (subject_type,subject_id)
#
class FocusSubscription < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :peer_info
end
