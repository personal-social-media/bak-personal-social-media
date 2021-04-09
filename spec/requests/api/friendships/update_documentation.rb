# frozen_string_literal: true

RSpec.shared_context "api_friendships_update" do
  let(:documentation_title) { "Update friendship" }
  let(:documentation_unescaped_url) { "/api/friendship" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      friendship: {
        friend_ship_status: {
          type: :string,
          variants: %w(accepted declined)
        }
      }
    }
  end
end
