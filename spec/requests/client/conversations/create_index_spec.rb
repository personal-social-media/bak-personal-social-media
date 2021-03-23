# frozen_string_literal: true

require "rails_helper"

describe "POST /client/conversations", vcr: :record_once do
  let(:url) { "/client/conversations" }
  let(:controller) { Client::ConversationsController }
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

  it "creates a new conversation" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:conversation]).to be_present
    end.to change { Conversation.count }.by(1)
  end
end
