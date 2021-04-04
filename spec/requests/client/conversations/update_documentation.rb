# frozen_string_literal: true

RSpec.shared_context "conversations_update_documentation" do
  let(:documentation_title) { "Update conversation" }
  let(:documentation_unescaped_url) { "/client/conversations/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {}
  end
end
