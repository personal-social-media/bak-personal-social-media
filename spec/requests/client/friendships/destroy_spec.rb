# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./destroy_documentation"
require "rails_helper"

describe "/client/friendships", vcr: { record: :once }, documentation: true do
  include_context "friendships_destroy_documentation"
  include_context "friendships_documentation"

  let(:controller) { Client::FriendshipsController }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223") }
  let(:url) { "/client/friendships/#{peer_info.id}" }
  let(:params) { { option: option } }

  before do
    sign_into_controller(controller)
  end

  subject do
    delete url, params: params
  end

  context "block", valid: true do
    let(:option) { :block }
    it "blocks the relationship" do
      expect do
        subject
        peer_info.reload
      end.to change { peer_info.friend_ship_status }.to "blocked"

      expect(response).to have_http_status(:ok)
    end
  end

  context "destroy" do
    let(:option) { :destroy }
    it "destroys the relationship" do
      peer_info
      expect do
        subject
      end.to change { PeerInfo.count }.by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
