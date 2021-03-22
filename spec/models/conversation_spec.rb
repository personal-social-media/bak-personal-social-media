# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id               :bigint           not null, primary key
#  has_new_messages :boolean          default(FALSE), not null
#  is_typing        :boolean          default(FALSE), not null
#  messages_count   :bigint           default(0), not null
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
require "rails_helper"

RSpec.describe Conversation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
