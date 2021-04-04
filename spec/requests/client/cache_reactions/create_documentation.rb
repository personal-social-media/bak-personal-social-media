# frozen_string_literal: true

RSpec.shared_context "cache_reactions_create_documentation" do
  let(:documentation_title) { "Create reaction" }
  let(:documentation_unescaped_url) { "/client/cache_reactions" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      cache_reaction: {
        payload_subject_type: {
          type: :string,
          variants: CacheReaction.payload_subject_types
        },
        payload_subject_id: {
          type: :uid
        },
        reaction_type: {
          type: :string,
          variants: CacheReaction.reaction_types
        },
        peer_info_id: {
          type: :id
        }
      }
    }
  end
end
