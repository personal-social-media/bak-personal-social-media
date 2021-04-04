# frozen_string_literal: true

RSpec.shared_context "static_documentation" do
  let(:documentation_parent_title) { "Helpers" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :static }
  let(:controller) { StaticController }
end
