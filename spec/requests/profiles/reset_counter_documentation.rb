# frozen_string_literal: true

RSpec.shared_context "profile_documentation_reset_counter" do
  let(:documentation_title) { "Reset counter" }
  let(:documentation_unescaped_url) { "/profile/reset_counter" }
  let(:documentation_id) { :reset_counter }
  let(:documentation_params) do
    {
      profile: {
        counter: {
          type: :string,
          variants: ProfileService::ResetCounter::PERMITTED_COUNTERS
        }
      }
    }
  end
end
