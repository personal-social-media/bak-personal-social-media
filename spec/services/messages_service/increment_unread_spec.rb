# frozen_string_literal: true

require "rails_helper"

describe MessagesService::IncrementUnread do
  describe "Message#increment_unread_messages_count!" do
    let(:message) { create(:message) }
    let(:profile) { create(:profile) }

    subject do
      message.increment_unread_messages_count!
      profile.reload
    end

    before do
      allow_any_instance_of(Message).to receive(:validate_signature).and_return true
    end
    it "changes unread_messages_count" do
      profile

      expect do
        subject
      end.to change { profile.unread_messages_count }.to 1
    end
  end
end
