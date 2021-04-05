# frozen_string_literal: true

# == Schema Information
#
# Table name: group_memberships
#
#  id           :bigint           not null, primary key
#  role         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  group_id     :bigint           not null
#  peer_info_id :bigint           not null
#
# Indexes
#
#  index_group_memberships_on_group_id      (group_id)
#  index_group_memberships_on_peer_info_id  (peer_info_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
FactoryBot.define do
  factory :group_membership do
    group { nil }
    role { "MyString" }
    peer_info { nil }
  end
end
