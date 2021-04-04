# frozen_string_literal: true

RSpec.shared_context "cache_reactions_index_documentation" do
  let(:documentation_title) { "List reactions" }
  let(:documentation_unescaped_url) { "/client/cache_reactions" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      search: [
        {
          payload_subject_id: {
            type: :uid
          },
          payload_subject_type: {
            type: :string,
            variants: CacheReaction.payload_subject_types
          }
        }
      ]
    }
  end
end
