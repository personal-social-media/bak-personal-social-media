# frozen_string_literal: true

require "rails_helper"

describe "PATCH /client/cache_comments/:id", vcr: :record_once do
  let(:url) { "/client/cache_comments/#{cache_comment.id}" }
  let(:controller) { Client::CacheCommentsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:cache_comment) { create(:cache_comment, subject: feed_item, remote_id: 2) }

  let(:params) do
    {
      cache_comment: {
        comment_type: :love
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
  end

  xit "updates new cache comment" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { cache_comment.reload.comment_type }.from("like").to("love")
  end
end
