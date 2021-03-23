# frozen_string_literal: true

require "rails_helper"

describe "GET /client/conversations" do
  let(:url) { "/client/conversations?peer_name=#{peer_info.name}" }
  let(:controller) { Client::ConversationsController }
  let(:conversation) { create(:conversation) }
  let(:peer_info) { conversation.peer_info }

  before do
    sign_into_controller(controller)
  end

  subject do
    get url
  end

  it "searches conversations" do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:conversations]).to be_present
    expect(json[:conversations_count]).to be_present
  end
end
