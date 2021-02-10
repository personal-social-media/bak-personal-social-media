# frozen_string_literal: true

# == Schema Information
#
# Table name: previous_searches
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  peer_info_id :bigint           not null
#
# Indexes
#
#  index_previous_searches_on_created_at    (created_at)
#  index_previous_searches_on_peer_info_id  (peer_info_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
class PreviousSearch < ApplicationRecord
  belongs_to :peer_info
  validates :peer_info_id, uniqueness: true
end
