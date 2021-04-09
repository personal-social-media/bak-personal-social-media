# frozen_string_literal: true

RSpec.shared_context "api_reactions" do
  let(:documentation_parent_title) { "Reactions" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_reactions }
  let(:controller) { Api::ReactionsController }
end
