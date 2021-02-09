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

  context "declined" do
    let(:option) { :declined }
    xit "declines the friendship" do
      expect do
        subject
      end.to change { peer_info.reload.friend_ship_status }.to "declined"
      expect(response).to have_http_status(:ok)
    end
  end

  context "accepted" do
    let(:option) { :accepted }
    xit "accepts the friendship" do
      expect do
        subject
      end.to change { peer_info.reload.friend_ship_status }.to "declined"
      expect(response).to have_http_status(:ok)
    end
  end
end
