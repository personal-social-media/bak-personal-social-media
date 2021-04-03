# frozen_string_literal: true

RSpec.shared_context "verification_results_index_documentation" do
  let(:documentation_title) { "List verifications" }
  let(:documentation_unescaped_url) { "/verification_results" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      search: [
        {
          remote_id: {
            type: :id
          },
          remote_type: {
            type: :string,
            variants: VerificationResult
          }
        }
      ]
    }
  end
end
