# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./mark_as_seen_documentation"

describe "/notifications/mark_as_seen", documentation: true do
  include ExternalApiHelpers
  include_context "notifications"
  include_context "mark_as_seen_notifications"

  describe "PATCH /notifications/mark_as_seen" do
    let(:url) { "/notifications/mark_as_seen" }
    let(:current_user) { create(:profile) }
    let(:notifications) { create_list(:notification, 4, subject: current_user) }
    let(:params) do
      { ids: ["all"] }
    end

    before do
      allow_any_instance_of(controller).to receive(:current_user).and_return(current_user)
    end

    subject do
      patch url, params: params
    end

    context "valid" do
      it "marks all notifications as seen", valid: true do
        notifications
        expect do
          subject
          expect(response).to have_http_status(:ok)
        end.to change { Notification.where(seen: true).count }.to(4)
      end
    end
  end
end
