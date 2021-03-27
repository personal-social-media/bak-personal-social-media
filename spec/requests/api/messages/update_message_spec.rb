# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "/api/messages/:id", documentation: true do
  include ExternalApiHelpers
  include_context "api_messages"
  include_context "api_messages_update"

  describe "PUT /api/messages/:id" do
    let(:url) { "/api/messages/#{message.id}" }
    let(:peer_info) { create(:peer_info, public_key: private_key.public_key.to_pem) }
    let(:conversation) { create(:conversation, peer_info: peer_info) }
    let(:message) { create(:message, conversation: conversation) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      allow_any_instance_of(Message).to receive(:validate_signature).and_return(true)
      request_as_verified
      request_as_server
    end

    subject do
      put url, params: params
    end

    context "valid" do
      let(:params) do
        {
          message: {
            read: true
          }
        }
      end
      it "updates the message", valid: true do
        message
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:message]).to be_present
          message.reload
        end.to change { message.read }
      end
    end
  end
end
