# frozen_string_literal: true

require "rails_helper"

describe "POST /client/cache_reactions", vcr: :record_once do
  let(:url) { "/client/cache_reactions" }
  let(:controller) { Client::CacheReactionsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }

  let(:params) do
    {
      cache_reaction: {
        subject_type: "FeedItem",
        subject_id: feed_item.id,
        reaction_type: :like
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "creates new cache reaction" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { CacheReaction.count }.by(1)
  end
end
