# frozen_string_literal: true

RSpec.shared_context "api_reactions_proof" do
  let(:documentation_title) { "Verify reaction proof" }
  let(:documentation_unescaped_url) { "/api/reactions/proof" }
  let(:documentation_id) { :proof }
  let(:documentation_params) do
    {
      payload_subject_id: {
        type: :id
      },
      payload_subject_type: {
        type: :string,
        variants: %w(post comment message)
      }
    }
  end
end
