# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "/api/conversations", documentation: true do
  include_context "api_conversations_create"
  include_context "api_conversations"
  include ExternalApiHelpers

  describe "POST /api/conversations" do
    let(:url) { "/api/conversations" }
    let(:peer_info) { create(:peer_info) }
    let(:params) { {} }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      post url
    end

    context "valid", valid: true do
      it "creates a conversation" do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:conversation]).to be_present
        end.to change { Conversation.count }.by(1)
      end
    end
  end
end
