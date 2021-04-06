# frozen_string_literal: true

RSpec.shared_context "api_conversations" do
  let(:documentation_parent_title) { "Conversations" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_conversations }
  let(:controller) { Api::ConversationsController }
end
