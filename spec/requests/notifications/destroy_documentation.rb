# frozen_string_literal: true

RSpec.shared_context "destroy_notifications" do
  let(:documentation_title) { "Destroys notifications" }
  let(:documentation_information) { "You can destroy all notifications by passing ['all'] as ids or specific such as [1,2,3]" }
  let(:documentation_unescaped_url) { "/notifications" }
  let(:documentation_id) { :destroy }
  let(:documentation_params) do
    {
      ids: {
        type: :array
      }
    }
  end
end
