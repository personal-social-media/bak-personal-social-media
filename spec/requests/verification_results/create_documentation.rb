# frozen_string_literal: true

RSpec.shared_context "verification_results_create_documentation" do
  let(:documentation_title) { "Reaction verifications" }
  let(:documentation_unescaped_url) { "/verification_results" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      verification_result: {
        remote_id: {
          type: :uid
        },
        remote_type: {
          type: :string,
          variants: VerificationResult.remote_types
        },
        peer_info_id: {
          type: :id
        }
      }
    }
  end
end
