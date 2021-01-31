# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id               :bigint           not null, primary key
#  has_new_messages :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  peer_info_id     :bigint           not null
#
# Indexes
#
#  index_conversations_on_peer_info_id  (peer_info_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
FactoryBot.define do
  factory :conversation do
    peer_info { nil }
    has_new_messages { false }
  end
end
