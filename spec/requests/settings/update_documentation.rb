# frozen_string_literal: true

RSpec.shared_context "settings_documentation_update" do
  let(:documentation_title) { "Update settings" }
  let(:documentation_unescaped_url) { "/setting" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      setting: {
        ui_sidebar_opened: {
          type: :boolean,
        }
      }
    }
  end
end
