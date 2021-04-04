# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./show_documentation"
require "rails_helper"

describe "GET /client/conversations/:id", documentation: true do
  include_context "conversations_documentation"
  include_context "conversations_show_documentation"

  let(:url) { "/client/conversations/#{peer_info.id}" }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:conversation) { create(:conversation, peer_info: peer_info) }

  before do
    sign_into_controller(controller)
  end

  subject do
    conversation
    get url
  end

  it "shows a conversation", valid: true do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:conversation]).to be_present
  end
end
