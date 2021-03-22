# frozen_string_literal: true

require "rails_helper"

describe "/api/conversations" do
  include ExternalApiHelpers
  let(:controller) { Api::ConversationsController }

  describe "PUT /api/conversations" do
    let(:url) { "/api/conversations" }
    let(:peer_info) { create(:peer_info) }
    let(:conversation) { create(:conversation, peer_info: peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      conversation
      put url, params: params
    end

    context "valid" do
      let(:params) do
        { conversation: { is_typing: true } }
      end

      it "updates the is_typing" do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:conversation]).to be_present
          conversation.reload
        end.to change { conversation.is_typing }
      end
    end
  end
end
