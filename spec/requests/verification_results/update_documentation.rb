# frozen_string_literal: true

RSpec.shared_context "verification_results_update_documentation" do
  let(:documentation_title) { "Retrigger verification" }
  let(:documentation_unescaped_url) { "/verification_results/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {}
  end
end
