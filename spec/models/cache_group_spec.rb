# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_groups
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  role         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  peer_info_id :bigint           not null
#  remote_id    :bigint           not null
#
# Indexes
#
#  index_cache_groups_on_peer_info_id  (peer_info_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
require "rails_helper"

RSpec.describe CacheGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
