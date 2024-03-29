# frozen_string_literal: true

require_relative "./create_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "POST /client/cache_reactions", vcr: :record_once, documentation: true do
  let(:url) { "/client/cache_reactions" }
  let(:controller) { Client::CacheReactionsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:new_cache_reaction) { CacheReaction.last }

  include_context "cache_reactions_documentation"
  include_context "cache_reactions_create_documentation"

  let(:params) do
    {
      cache_reaction: {
        payload_subject_type: :post,
        payload_subject_id: uid,
        reaction_type: :like,
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

  it "creates new cache reaction", valid: true do
    feed_item
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:cache_reaction]).to be_present

      expect(new_cache_reaction.subject).to be_present
    end.to change { CacheReaction.count }.by(1)
  end
end
