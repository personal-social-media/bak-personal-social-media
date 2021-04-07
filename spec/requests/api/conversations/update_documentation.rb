# frozen_string_literal: true

RSpec.shared_context "api_conversations_update" do
  let(:documentation_title) { "Update conversation" }
  let(:documentation_unescaped_url) { "/api/conversations" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      conversation: {
        is_typing: {
          type: :boolean
        }
      }
    }
  end
end
