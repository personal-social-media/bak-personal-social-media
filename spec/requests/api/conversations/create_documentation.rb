# frozen_string_literal: true

RSpec.shared_context "api_conversations_create" do
  let(:documentation_title) { "Create conversation" }
  let(:documentation_unescaped_url) { "/api/conversations" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {}
  end
end
