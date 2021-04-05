# frozen_string_literal: true

RSpec.shared_context "api_friendships_index" do
  let(:documentation_title) { "List friendships" }
  let(:documentation_information) { "List friendships" }
  let(:documentation_unescaped_url) { "/api/friendships" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      page: { type: :number, optional: true }, start_index: { type: :number, optional: true }, end_index: { type: :number, optional: true }
    }
  end
end
