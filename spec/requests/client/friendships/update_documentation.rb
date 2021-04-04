# frozen_string_literal: true

RSpec.shared_context "friendships_update_documentation" do
  let(:documentation_title) { "Updates the friendship" }
  let(:documentation_unescaped_url) { "/client/friendships" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      option: {
        type: :string,
        variants: %w(declined accepted)
      }
    }
  end
end
