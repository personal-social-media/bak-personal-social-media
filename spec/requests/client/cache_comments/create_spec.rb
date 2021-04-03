# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "POST /client/cache_comments", vcr: :record_once, documentation: true do
  include FilesSpecHelper

  let(:url) { "/client/cache_comments/upload" }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:new_cache_comment) { CacheComment.last }
  include_context "cache_comments_documentation"
  include_context "cache_comments_create_documentation"

  let(:params) do
    {
      cache_comment: {
        subject_type: "FeedItem",
        subject_id: feed_item.id,
        parent_comment_id: nil,
        payload_subject_type: :post,
        payload_subject_id: uid,
        payload: {
          message: "test",
        },
        peer_info_id: peer_info.id,
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
    post url, params: params

    SyncService::SyncComment.new(new_cache_comment).call_create!
  end

  it "creates new cache comment", valid: true do
    expect do
      subject
      expect(response).to have_http_status(:ok)

      expect(new_cache_comment.subject).to be_present
      expect(new_cache_comment.attached_files).to be_present
      expect(new_cache_comment.remote_id).to be_present
    end.to change { CacheComment.count }.by(1)
  end
end
