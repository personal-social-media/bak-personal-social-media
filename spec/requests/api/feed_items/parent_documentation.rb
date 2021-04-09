# frozen_string_literal: true

RSpec.shared_context "api_feed_items" do
  let(:documentation_parent_title) { "Feed Items" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_feed_items }
  let(:controller) { Api::FeedItemsController }
end
