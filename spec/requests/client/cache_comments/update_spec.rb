# frozen_string_literal: true

require "rails_helper"

describe "PATCH /client/cache_comments/:id", vcr: :record_once do
  let(:url) { "/client/cache_comments/#{cache_comment.id}" }
  let(:controller) { Client::CacheCommentsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:cache_comment) { create(:cache_comment, subject: feed_item, remote_id: 1) }

  let(:payload) do
    {
      message: "test2",
      subject_type: "FeedItem",
      subject_id: feed_item.id,
      parent_comment_id: nil,
      images: [
        {
          type: :image,
          desktop: "https://example.com/a.jpg",
          mobile: "https://example.com/a.jpg",
          thumbnail: "https://example.com/a.jpg",
        }
      ],
      videos: [
        {
          type: :video,
          original: "https://example.com/a.mp4",
          short: "https://example.com/a.mp4",
          original_screenshot: "https://example.com/a.jpg",
          thumbnail_screenshot: "https://example.com/a.jpg",
        }
      ]
    }
  end

  let(:params) do
    {
      cache_comment: {
        payload: payload
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
  end

  it "updates cache comment" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { cache_comment.reload.payload }
  end
end
