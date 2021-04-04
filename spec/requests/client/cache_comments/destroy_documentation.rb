# frozen_string_literal: true

RSpec.shared_context "cache_comments_destroy_documentation" do
  let(:documentation_title) { "Destroy comment" }
  let(:documentation_unescaped_url) { "/client/cache_comments" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {}
  end
end
