# frozen_string_literal: true

RSpec.shared_context "api_messages_create" do
  let(:documentation_title) { "Creates a message" }
  let(:documentation_unescaped_url) { "/api/messages" }
  let(:documentation_id) { :create }
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
