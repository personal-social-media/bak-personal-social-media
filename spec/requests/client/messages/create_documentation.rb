# frozen_string_literal: true

RSpec.shared_context "client_create_messages_documentation" do
  let(:documentation_title) { "Create message" }
  let(:documentation_unescaped_url) { "/client/conversations/:conversation_id/messages/upload" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      message: {
        payload: {
          message: {
            type: :string
          }
        },
        uploaded_files: {
          type: :files,
          list: true
        }
      }
    }
  end
end
