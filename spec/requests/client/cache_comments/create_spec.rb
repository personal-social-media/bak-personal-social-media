# frozen_string_literal: true

require "rails_helper"

describe "POST /client/cache_comments", vcr: :record_once do
  let(:url) { "/client/cache_comments" }
  let(:controller) { Client::CacheCommentsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:new_cache_comment) { CacheComment.last }

  let(:payload) do
    {
      message: "test",
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
        payload_subject_type: :post,
        payload_subject_id: uid,
        payload: payload,
        peer_info_id: peer_info.id
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "creates new cache comment" do
    expect do
      subject
      expect(response).to have_http_status(:ok)

      expect(new_cache_comment.subject).to be_present
    end.to change { CacheComment.count }.by(1)
  end
end
