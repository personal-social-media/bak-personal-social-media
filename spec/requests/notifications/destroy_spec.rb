# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./destroy_documentation"

describe "/notifications", documentation: true do
  include ExternalApiHelpers
  include_context "notifications"
  include_context "destroy_notifications"

  describe "DELETE /notifications" do
    let(:url) { "/notifications" }
    let(:current_user) { create(:profile) }
    let(:notifications) { create_list(:notification, 4, subject: current_user) }
    let(:params) do
      { ids: ["all"] }
    end

    before do
      allow_any_instance_of(controller).to receive(:current_user).and_return(current_user)
    end

    subject do
      delete url, params: params
    end

    context "valid" do
      it "destroys notifications", valid: true do
        notifications
        expect do
          subject
          expect(response).to have_http_status(:ok)
        end.to change { Notification.count }.to(0)
      end
    end
  end
end
