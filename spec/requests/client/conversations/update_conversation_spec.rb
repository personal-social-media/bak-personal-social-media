# frozen_string_literal: true

require_relative "./update_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "PUT /client/conversations/:id", vcr: :record_once, documentation: true do
  include_context "conversations_documentation"
  include_context "conversations_update_documentation"

  let(:url) { "/client/conversations/#{conversation.id}" }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:conversation) { create(:conversation, peer_info: peer_info) }
  let(:params) do
    {
      conversation: {
        is_typing: true
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    put url, params: params
    conversation.reload
  end

  it "updates the conversation", valid: true do
    conversation
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:conversation]).to be_present
    end.to change { conversation.is_typing }.to true
  end
end
