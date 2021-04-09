# frozen_string_literal: true

RSpec.shared_context "identities_ping" do
  let(:documentation_title) { "Ping identity" }
  let(:documentation_unescaped_url) { "/identities/ping" }
  let(:documentation_id) { :ping }
  let(:documentation_params) do
    {}
  end
end
