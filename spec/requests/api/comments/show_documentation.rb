# frozen_string_literal: true

RSpec.shared_context "api_comments_show" do
  let(:documentation_title) { "Show comment" }
  let(:documentation_unescaped_url) { "/api/comments/:id" }
  let(:documentation_id) { :show }
  let(:documentation_params) do
    {}
  end
end
