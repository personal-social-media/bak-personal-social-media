# frozen_string_literal: true

RSpec.shared_context "cache_reactions_documentation" do
  let(:documentation_parent_title) { "Client reactions" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :cache_reactions }
  let(:controller) { Client::CacheReactionsController }
end
