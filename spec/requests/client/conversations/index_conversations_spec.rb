# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./index_documentation"
require "rails_helper"

describe "GET /client/conversations", documentation: true do
  let(:url) { "/client/conversations?peer_name=#{peer_info.name}" }
  let(:conversation) { create(:conversation) }
  let(:peer_info) { conversation.peer_info }
  include_context "conversations_documentation"
  include_context "conversations_index_documentation"

  before do
    sign_into_controller(controller)
  end

  subject do
    get url
  end

  it "searches conversations", valid: true do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:conversations]).to be_present
    expect(json[:conversations_count]).to be_present
  end
end
