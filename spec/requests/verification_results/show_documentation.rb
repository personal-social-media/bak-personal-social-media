# frozen_string_literal: true

RSpec.shared_context "verification_results_show_documentation" do
  let(:documentation_title) { "Shows a verification" }
  let(:documentation_unescaped_url) { "/verification_results/:id" }
  let(:documentation_id) { :show }
  let(:documentation_params) do
    {}
  end
end
