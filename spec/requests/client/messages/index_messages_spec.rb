# frozen_string_literal: true

require "rails_helper"

describe "GET /client/conversations/:conversation_id/messages" do
  let(:conversation) { create(:conversation) }
  let(:url) { "/client/conversations/#{conversation.id}/messages" }
  let(:messages) { create_list(:message, 2, conversation: conversation) }

  before do
    sign_into_controller(Client::MessagesController)
  end

  subject do
    messages
    get url
  end

  it "ok" do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:messages]).to be_present
    expect(json[:messages_count]).to eq(2)
  end
end
