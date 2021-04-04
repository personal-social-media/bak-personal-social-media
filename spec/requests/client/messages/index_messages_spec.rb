# frozen_string_literal: true

require_relative "./parent_documentation"
require "rails_helper"

describe "GET /client/conversations/:conversation_id/messages", documentation: true do
  include_context "client_messages_documentation"

  let(:documentation_title) { "List messages" }
  let(:documentation_unescaped_url) { "/client/conversations/:conversation_id/messages" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      page: { type: :number, optional: true }, start_index: { type: :number, optional: true }, end_index: { type: :number, optional: true },
      conversation_id: {
        type: :number
      }
    }
  end

  let(:conversation) { create(:conversation) }
  let(:url) { "/client/conversations/#{conversation.id}/messages" }
  let(:messages) { create_list(:message, 2, conversation: conversation, message_owner: :self) }

  before do
    sign_into_controller(controller)
  end

  subject do
    messages
    get url
  end

  it "ok", valid: true do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:messages]).to be_present
    expect(json[:messages_count]).to eq(2)
  end
end
