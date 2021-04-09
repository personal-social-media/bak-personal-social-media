# frozen_string_literal: true

RSpec.shared_context "api_reactions_update" do
  let(:documentation_title) { "Update reaction" }
  let(:documentation_unescaped_url) { "/api/reactions/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      reaction: {
        reaction_type: {
          type: :string,
          variants: Reaction.reaction_types
        }
      }
    }
  end
end
