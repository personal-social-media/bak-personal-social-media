# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_reactions
#
#  id                   :bigint           not null, primary key
#  payload_subject_type :string           default(""), not null
#  reaction_type        :string           not null
#  subject_type         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  payload_subject_id   :string           default(""), not null
#  peer_info_id         :bigint           not null
#  remote_id            :bigint           not null
#  subject_id           :bigint
#
# Indexes
#
#  index_cache_reactions_on_peer_info_id                 (peer_info_id)
#  index_cache_reactions_on_subject_id_and_subject_type  (subject_id,subject_type) UNIQUE WHERE ((subject_id IS NOT NULL) AND (subject_type IS NOT NULL))
#  payload_index                                         (payload_subject_type,payload_subject_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
require "rails_helper"

RSpec.describe CacheReaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
