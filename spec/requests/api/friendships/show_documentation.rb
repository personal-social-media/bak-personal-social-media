# frozen_string_literal: true

RSpec.shared_context "api_friendships_show" do
  let(:documentation_title) { "Show friendship" }
  let(:documentation_unescaped_url) { "/api/friendship" }
  let(:documentation_id) { :show }
  let(:documentation_params) do
    {}
  end
end
