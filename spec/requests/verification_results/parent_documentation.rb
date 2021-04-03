# frozen_string_literal: true

RSpec.shared_context "verification_results_documentation" do
  let(:documentation_parent_title) { "Like verifications" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :verification_results }
  let(:controller) { VerificationResultsController }
end
