# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "POST /client/conversations", vcr: :record_once, documentation: true do
  include_context "conversations_create_documentation"
  include_context "conversations_documentation"
  let(:url) { "/client/conversations" }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:params) do
    {
      conversation: {
        peer_info_id: peer_info.id
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "creates a new conversation", valid: true do
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:conversation]).to be_present
    end.to change { Conversation.count }.by(1)
  end
end
