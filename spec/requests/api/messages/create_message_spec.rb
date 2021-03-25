# frozen_string_literal: true

require "rails_helper"

describe "/api/messages" do
  include ExternalApiHelpers
  let(:controller) { Api::MessagesController }

  describe "POST /api/messages" do
    let(:url) { "/api/messages" }
    let(:peer_info) { create(:peer_info, public_key: private_key.public_key.to_pem) }
    let(:conversation) { create(:conversation, peer_info: peer_info) }
    let(:payload) do
      {
        message: "Sample message"
      }
    end

    let(:signature) { SignaturesService::Sign.new(payload.to_json).call! }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      post url, params: params
    end

    context "valid" do
      let(:params) do
        {
          message: {
            remote_id: 1,
            message_type: :text,
            signature: signature,
            payload: payload
          }
        }
      end
      it "creates a message" do
        conversation
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:message]).to be_present
          conversation.reload
        end.to change { Message.count }.by(1)
          .and change { conversation.has_new_messages }
          .and change { conversation.messages_count }.by(1)
      end
    end
  end
end
