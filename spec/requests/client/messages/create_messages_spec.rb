# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "POST /client/conversations/:conversation_id/messages", documentation: true, vcr: :record_once do
  include FilesSpecHelper
  include_context "client_messages_documentation"

  context "valid", valid: true do
    include_context "client_create_messages_documentation"
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
    let(:conversation) { create(:conversation, peer_info: peer_info) }
    let(:url) { "/client/conversations/#{conversation.id}/messages" }
    let(:message) { Message.last }
    let(:params) do
      {
        message: {
          payload: {
            message: "new message"
          },
          uploaded_files: [
            {
              ".name": "a.png",
              ".path": sample_image_tmp,
              ".md5": "md5"
            }
          ]
        }
      }
    end

    before do
      sign_into_controller(controller)
    end

    subject do
      post url, params: params

      SyncService::SyncMessage.new(message).call_create!
    end

    it "ok", valid: true do
      expect do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:message]).to be_present
        message.reload
        expect(message.remote_id).to be_present
      end.to change { Message.count }.by(1)
    end
  end
end
