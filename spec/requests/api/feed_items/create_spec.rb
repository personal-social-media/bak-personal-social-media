# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "/api/feed_items", documentation: true do
  include_context "api_feed_items"
  include_context "api_create_feed_items"
  include ExternalApiHelpers

  describe "POST /api/feed_items" do
    let(:url) { "/api/feed_items" }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      peer_info
      post url, params: params
    end

    context "valid", valid: true do
      let(:params) do
        {
          feed_item: {
            url: "https://161.97.64.223/",
            uid: "UID-#{SecureRandom.hex}",
            feed_item_type: :post,
            feed_item_id: 1
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
            uid: "UID-#{SecureRandom.hex}",
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
