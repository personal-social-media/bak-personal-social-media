# frozen_string_literal: true

require "rails_helper"

describe "PUT /client/conversations/:id", vcr: :record_once do
  let(:url) { "/client/conversations/#{conversation.id}" }
  let(:controller) { Client::ConversationsController }
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
  end

  it "updates the conversation" do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:conversation]).to be_present
  end
end
