# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./update_documentation"

describe "/setting", documentation: true do
  include_context "settings_documentation"
  include_context "settings_documentation_update"
  let(:url) { "/setting" }
  let(:setting) { create(:setting) }
  let(:params) do
    {
      setting: {
        ui_sidebar_opened: false
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
    setting.reload
  end

  it "updates the setting", valid: true do
    setting

    subject
    expect(response).to have_http_status(:ok)
    expect(json[:setting]).to be_present
    expect(setting.ui_sidebar_opened).to be_falsey
  end
end
