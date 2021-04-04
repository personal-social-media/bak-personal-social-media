# frozen_string_literal: true

RSpec.shared_context "static_public_key_documentation" do
  let(:documentation_title) { "Show public key" }
  let(:documentation_unescaped_url) { "/public_key" }
  let(:documentation_id) { :public_key }
  let(:documentation_params) do
    {}
  end
end
