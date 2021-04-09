# frozen_string_literal: true

RSpec.shared_context "api_reactions_index" do
  let(:documentation_title) { "List reactions" }
  let(:documentation_unescaped_url) { "/api/reactions" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      page: { type: :number, optional: true }, start_index: { type: :number, optional: true }, end_index: { type: :number, optional: true }
    }
  end
end
