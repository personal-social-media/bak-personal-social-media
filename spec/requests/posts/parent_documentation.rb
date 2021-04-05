# frozen_string_literal: true

RSpec.shared_context "posts_documentation" do
  let(:documentation_parent_title) { "Posts" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :posts_documentation }
  let(:controller) { PostsController }
end
