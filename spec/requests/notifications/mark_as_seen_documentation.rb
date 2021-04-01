# frozen_string_literal: true

RSpec.shared_context "mark_as_seen_notifications" do
  let(:documentation_title) { "Marks notifications as seen" }
  let(:documentation_information) { "You can mark all notifications as seen by passing ['all'] as ids or specific such as [1,2,3]" }
  let(:documentation_unescaped_url) { "/notifications/mark_as_seen" }
  let(:documentation_id) { :mark_as_seen }
  let(:documentation_params) do
    {
      ids: {
        type: :array
      }
    }
  end
end
