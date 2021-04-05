# frozen_string_literal: true

RSpec.shared_context "api_comments_destroy" do
  let(:documentation_title) { "Destroy message" }
  let(:documentation_unescaped_url) { "/api/comments/:id" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {}
  end
end
