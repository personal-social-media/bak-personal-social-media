# frozen_string_literal: true

RSpec.shared_context "api_comments" do
  let(:documentation_parent_title) { "Comments Server Side" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_comments }
  let(:controller) { Api::CommentsController }
end
