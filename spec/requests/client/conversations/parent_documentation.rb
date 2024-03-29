# frozen_string_literal: true

RSpec.shared_context "conversations_documentation" do
  let(:documentation_parent_title) { "Conversations" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :client_conversations  }
  let(:controller) { Client::ConversationsController }
end
