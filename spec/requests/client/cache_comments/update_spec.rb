# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "PATCH /client/cache_comments/:id", vcr: :record_once, documentation: true do
  include FilesSpecHelper
  let(:url) { "/client/cache_comments/upload" }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post) }
  let(:cache_comment) { create(:cache_comment, subject: feed_item, remote_id: 2, peer_info: peer_info) }
  include_context "cache_comments_documentation"
  include_context "cache_comments_update_documentation"

  let(:params) do
    {
      id: cache_comment.id,
      cache_comment: {
        payload: {
          message: "test2"
        },
        like_count: 1,
        love_count: 1,
        wow_count: 1,
        uploaded_files: [
          {
            ".name": "a.png",
            ".path": sample_image_tmp,
            ".md5": "md5"
          }
        ]
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
    cache_comment.reload
    SyncService::SyncComment.new(cache_comment).call_update!
  end

  it "updates cache comment", valid: true do
    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { cache_comment.payload }
       .and change { cache_comment.like_count }
       .and change { cache_comment.love_count }
       .and change { cache_comment.wow_count }
  end
end
