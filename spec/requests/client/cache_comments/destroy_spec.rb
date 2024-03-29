# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./destroy_documentation"
require "rails_helper"

describe "DELETE /client/cache_comments/:id", vcr: :record_once, documentation: true do
  let(:url) { "/client/cache_comments/#{cache_comment.id}" }
  let(:controller) { Client::CacheCommentsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:cache_comment) { create(:cache_comment, subject: feed_item, remote_id: 1, peer_info: peer_info) }

  include_context "cache_comments_documentation"
  include_context "cache_comments_destroy_documentation"

  before do
    sign_into_controller(controller)
  end

  subject do
    delete url
  end

  it "deletes the cache comment", valid: true do
    cache_comment

    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { CacheComment.count }.by(-1)
  end
end
