# frozen_string_literal: true

# == Schema Information
#
# Table name: unblock_requests
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  peer_info_id           :bigint           not null
#  peer_info_requester_id :bigint           not null
#
# Indexes
#
#  index_unblock_requests_on_peer_info_id            (peer_info_id)
#  index_unblock_requests_on_peer_info_requester_id  (peer_info_requester_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#  fk_rails_...  (peer_info_requester_id => peer_infos.id)
#
class UnblockRequest < ApplicationRecord
end
