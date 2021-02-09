# frozen_string_literal: true

require "rails_helper"

describe "/client/friendships", vcr: { record: :once } do
  let(:controller) { Client::FriendshipsController }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :pending_accept) }
  let(:url) { "/client/friendships/#{peer_info.id}" }
  let(:params) { { option: option } }

  before do
    sign_into_controller(controller)
  end

  subject do
    patch url, params: params
  end

  context "accepted" do
    let(:option) { :block }
    xit "accepts the friendship" do
      subject
      # expect do
      #   subject
      # end.to change { peer_info.reload.friend_ship_status }.to "blocked"
      #
      # expect(response).to have_http_status(:ok)
    end
  end

  context "declined" do
    let(:option) { :destroy }
    xit "declines the friendship" do
      peer_info
      expect do
        subject
      end.to change { PeerInfo.count }.by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
