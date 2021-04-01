# frozen_string_literal: true

RSpec.shared_context "notifications" do
  let(:documentation_parent_title) { "Notifications" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :notifications }
  let(:controller) { NotificationsController }
end
