# frozen_string_literal: true

require_relative "./index_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "PATCH /client/cache_reactions/:id", vcr: :record_once, documentation: true do
  let(:url) { "/client/cache_reactions/#{cache_reaction.id}" }
  let(:controller) { Client::CacheReactionsController }
  let(:params) { { id: peer_info.id } }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  let(:cache_reaction) { create(:cache_reaction, subject: feed_item, remote_id: 2, peer_info: peer_info) }
  include_context "cache_reactions_documentation"
  include_context "cache_reactions_update_documentation"

  let(:params) do
    {
      cache_reaction: {
        reaction_type: :love
      }
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
  end

  it "updates new cache reaction", valid: true do
    expect do
      subject
      expect(response).to have_http_status(:ok)

      expect(json[:cache_reaction]).to be_present
    end.to change { cache_reaction.reload.reaction_type }.from("like").to("love")
  end
end
