# frozen_string_literal: true

RSpec.shared_context "conversations_create_documentation" do
  let(:documentation_title) { "Create a new conversation" }
  let(:documentation_unescaped_url) { "/client/conversations" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      conversation: {
        peer_info_id: {
          type: :id
        }
      }
    }
  end
end
