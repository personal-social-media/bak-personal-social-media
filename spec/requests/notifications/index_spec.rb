# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./index_documentation"

describe "/notifications", documentation: true do
  include ExternalApiHelpers
  include_context "notifications"
  include_context "index_notifications"

  describe "GET /notifications" do
    let(:url) { "/notifications" }
    let(:current_user) { create(:profile) }
    let(:notifications) { create_list(:notification, 4, subject: current_user) }

    before do
      allow_any_instance_of(controller).to receive(:current_user).and_return(current_user)
    end

    subject do
      notifications
      get url
    end

    context "valid" do
      it "lists notifications", valid: true do
        subject
        expect(response).to have_http_status(:ok)
        expect(json[:notifications]).to be_present
        expect(json[:notifications_count]).to be_present
        expect(json[:notifications_not_seen_count]).to be_present
      end
    end
  end
end
