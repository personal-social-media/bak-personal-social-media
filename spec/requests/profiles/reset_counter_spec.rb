# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./reset_counter_documentation"

describe "/profile/reset_counter", documentation: true do
  include_context "profile_documentation_reset_counter"
  include_context "profile_documentation"
  let(:url) { "/profile/reset_counter" }
  let(:params) do
    {
      profile: {
        counter: :not_seen_notifications_count
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
    current_user.reload
  end

  it "resets counter", valid: true do
    current_user.update(not_seen_notifications_count: 10)

    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { current_user.not_seen_notifications_count }.to(0)
  end
end
