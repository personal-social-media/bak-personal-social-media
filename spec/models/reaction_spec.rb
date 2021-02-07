# frozen_string_literal: true

# == Schema Information
#
# Table name: reactions
#
#  id            :bigint           not null, primary key
#  reaction_type :string           not null
#  subject_type  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  peer_info_id  :bigint
#  subject_id    :bigint           not null
#
# Indexes
#
#  index_reactions_on_peer_info_id_and_subject_id  (peer_info_id,subject_id) UNIQUE
#  index_reactions_on_subject                      (subject_type,subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
require "rails_helper"

RSpec.describe Reaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
