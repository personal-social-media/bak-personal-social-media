# frozen_string_literal: true

RSpec.shared_context "client_update_messages_documentation" do
  let(:documentation_title) { "Update message" }
  let(:documentation_unescaped_url) { "/client/messages/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      message: {
        read: {
          type: :boolean
        }
      }
    }
  end
end
