# frozen_string_literal: true

RSpec.shared_context "api_reactions_destroy" do
  let(:documentation_title) { "Destroy reaction" }
  let(:documentation_unescaped_url) { "/api/reactions/:id" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {}
  end
end
