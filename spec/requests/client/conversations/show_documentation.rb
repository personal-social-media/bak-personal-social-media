# frozen_string_literal: true

RSpec.shared_context "conversations_show_documentation" do
  let(:documentation_title) { "Shows conversation" }
  let(:documentation_unescaped_url) { "/client/conversations/:peer_id" }
  let(:documentation_id) { :show }
  let(:documentation_params) do
    {}
  end
end
