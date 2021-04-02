# frozen_string_literal: true

RSpec.shared_context "cache_comments_documentation" do
  let(:documentation_parent_title) { "Local Comments" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :cache_comments }
  let(:controller) { Client::CacheCommentsController }
end
