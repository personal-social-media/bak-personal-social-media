# frozen_string_literal: true

require "rails_helper"

describe "/api/feed_items" do
  include ExternalApiHelpers
  let(:controller) { Api::FeedItemsController }


  describe "POST /api/feed_items" do
    let(:url) { "/api/feed_items" }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      peer_info
      post url, params: params
    end

    context "valid" do
      let(:params) do
        {
          feed_item: {
            url: "https://161.97.64.223/",
            uid: SecureRandom.hex,
            feed_item_type: :post
          }
        }
      end

      it "creates a new feed item" do
        expect do
          subject
        end.to change { peer_info.feed_items.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context "invalid" do
      let(:params) do
        {
          feed_item: {
            url: "",
            uid: SecureRandom.hex,
            feed_item_type: :post
          }
        }
      end

      it "nothing" do
        expect do
          subject
        end.to change { peer_info.feed_items.count }.by(0)

        expect(response).to have_http_status(422)
      end
    end
  end
end
