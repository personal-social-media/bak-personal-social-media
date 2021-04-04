# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "/client/friendships", vcr: { record: :once }, documentation: true do
  include_context "friendships_documentation"
  include_context "friendships_update_documentation"

  let(:controller) { Client::FriendshipsController }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :pending_accept) }
  let(:url) { "/client/friendships/#{peer_info.id}" }
  let(:params) { { option: option } }

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
    peer_info.reload
  end

  context "declined" do
    let(:option) { :declined }
    it "declines the friendship" do
      expect do
        subject
      end.to change { peer_info.friend_ship_status }.to "declined"
      expect(response).to have_http_status(:ok)
    end
  end

  context "accepted", valid: true do
    let(:option) { :accepted }
    it "accepts the friendship" do
      expect do
        subject
      end.to change { peer_info.friend_ship_status }.to "accepted"
      expect(response).to have_http_status(:ok)
    end
  end
end
