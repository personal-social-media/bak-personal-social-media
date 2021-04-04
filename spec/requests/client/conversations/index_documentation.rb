# frozen_string_literal: true

RSpec.shared_context "conversations_index_documentation" do
  let(:documentation_title) { "List conversations" }
  let(:documentation_unescaped_url) { "/client/conversations" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      peer_name: {
        type: :string,
        optional: true
      },
      page: { type: :number, optional: true }, start_index: { type: :number, optional: true }, end_index: { type: :number, optional: true },
    }
  end
end
