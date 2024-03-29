# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id                :bigint           not null, primary key
#  message_owner     :string           default(""), not null
#  message_type      :string           not null
#  payload           :text             default({}), not null
#  processing_status :string           default("processing"), not null
#  read              :boolean          default(FALSE), not null
#  signature         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  conversation_id   :bigint           not null
#  remote_id         :bigint
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_remote_id        (remote_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#
require "rails_helper"

RSpec.describe Message, type: :model do
  describe "#push_message" do
    let(:notification) { create(:notification) }

    it "pushes to action cable" do
      allow_any_instance_of(MessagesChannel::PushMessage).to receive(:push).at_least(:once)
      notification.push_notification
    end
  end
end
