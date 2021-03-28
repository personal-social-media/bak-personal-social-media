# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "PUT /client/messages/:id", vcr: :record_once do
  include FilesSpecHelper
  include_context "client_messages_documentation"
  include_context "client_update_messages_documentation"

  context "valid", valid: true do
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
    let(:conversation) { create(:conversation, peer_info: peer_info) }
    let(:message) { create(:message, conversation: conversation) }
    let(:url) { "/client/messages/#{message.id}" }
    let(:params) do
      {
        message: {
          read: true
        }
      }
    end

    before do
      allow_any_instance_of(Message).to receive(:validate_signature).and_return(true)
      sign_into_controller(controller)
    end

    subject do
      put url, params: params
      message.reload
      SyncService::SyncMessage.new(message).call_update!
    end

    xit "ok", valid: true do
      expect do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:message]).to be_present
      end.to change { message.read }
    end
  end
end
