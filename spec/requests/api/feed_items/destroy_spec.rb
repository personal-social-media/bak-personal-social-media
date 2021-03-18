# frozen_string_literal: true

require "rails_helper"

describe "/api/feed_items/:id" do
  include ExternalApiHelpers
  let(:controller) { Api::FeedItemsController }

  describe "DELETE /api/feed_items/:id" do
    let(:url) { "/api/feed_items/#{feed_item.uid}" }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
    let(:feed_item) { create(:feed_item, peer_info: peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      delete url
    end

    it "destroys the feed item", skip_propsite: true do
      feed_item

      expect do
        subject
        expect(response).to have_http_status(:ok)
      end.to change { FeedItem.count }.by(-1)
    end
  end
end
