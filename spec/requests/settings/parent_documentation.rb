# frozen_string_literal: true

RSpec.shared_context "settings_documentation" do
  let(:documentation_parent_title) { "Settings" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :settings }
  let(:controller) { SettingsController }
end
