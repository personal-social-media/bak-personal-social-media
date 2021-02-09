# frozen_string_literal: true

require "rails_helper"

describe "/client/friendships", vcr: { record: :once } do
  let(:controller) { Client::FriendshipsController }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :stranger )}
  let(:url) { "/client/friendships" }
  let(:params) { { id: peer_info.id }}

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "updates the friendship" do
    subject
  end
end