# frozen_string_literal: true

RSpec.shared_context "cache_reactions_update_documentation" do
  let(:documentation_title) { "Update a reaction" }
  let(:documentation_unescaped_url) { "/client/cache_reactions/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      cache_reaction: {
        reaction_type: {
          type: :string,
          variants: CacheReaction.reaction_types
        }
      }
    }
  end
end
