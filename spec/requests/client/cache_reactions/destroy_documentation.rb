# frozen_string_literal: true

RSpec.shared_context "cache_reactions_destroy_documentation" do
  let(:documentation_title) { "Destroys a reaction" }
  let(:documentation_unescaped_url) { "/client/cache_reactions/:id" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {}
  end
end
