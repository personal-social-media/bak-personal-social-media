# frozen_string_literal: true

RSpec.shared_context "profile_documentation" do
  let(:documentation_parent_title) { "Profile" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :profile }
  let(:controller) { ProfilesController }
end
