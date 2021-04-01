# frozen_string_literal: true

RSpec.shared_context "index_notifications" do
  let(:documentation_title) { "Lists all notifications" }
  let(:documentation_unescaped_url) { "/notifications" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      page: {
        type: :number,
        optional: true
      },
      start_index: {
        type: :number,
        optional: true
      },
      end_index: {
        type: :number,
        optional: true
      }
    }
  end
end
