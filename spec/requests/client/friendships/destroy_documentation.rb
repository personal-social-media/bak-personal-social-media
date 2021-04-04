# frozen_string_literal: true

RSpec.shared_context "friendships_destroy_documentation" do
  let(:documentation_title) { "Destroy a friendship" }
  let(:documentation_unescaped_url) { "/client/friendships/:id" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {
      option: {
        type: :string,
        variants: %w[block destroy]
      }
    }
  end
end
