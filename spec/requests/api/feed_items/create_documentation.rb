# frozen_string_literal: true

RSpec.shared_context "api_create_feed_items" do
  let(:documentation_title) { "Create feed item" }
  let(:documentation_unescaped_url) { "/api/feed_items" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      feed_item: {
        url: {
          type: :url
        },
        uid: {
          type: :uid
        },
        feed_item_type: {
          type: :string,
          variants: FeedItem.feed_item_types
        },
        feed_item_id: {
          type: :id
        }
      }
    }
  end
end
