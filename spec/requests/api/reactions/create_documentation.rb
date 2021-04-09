# frozen_string_literal: true

RSpec.shared_context "api_reactions_create" do
  let(:documentation_title) { "Create reaction" }
  let(:documentation_unescaped_url) { "/api/reactions" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      reaction: {
        subject_type: {
          type: :string,
          variants: %w(post message comment)
        },
        subject_id: {
          type: :uid
        },
        reaction_type: {
          type: :string,
          variants: Reaction.reaction_types
        }
      }
    }
  end
end
