# frozen_string_literal: true

RSpec.shared_context "api_messages_update" do
  let(:documentation_title) { "Update message" }
  let(:documentation_unescaped_url) { "/api/messages/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      message: {
        read: {
          type: :boolean
        },
      },
    }
  end
end
