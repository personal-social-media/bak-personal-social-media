# frozen_string_literal: true

RSpec.shared_context "friendships_create_documentation" do
  let(:documentation_title) { "Create friendship" }
  let(:documentation_unescaped_url) { "/client/friendships" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      id: {
        type: :id
      }
    }
  end
end
