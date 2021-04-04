# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "/client/friendships", vcr: { record: :once }, documentation: true do
  include_context "friendships_create_documentation"
  include_context "friendships_documentation"
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :stranger) }
  let(:url) { "/client/friendships" }
  let(:params) { { id: peer_info.id } }

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
    peer_info.reload
  end

  it "creates the friendship", valid: true do
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:peer_info]).to be_present
    end.to change { peer_info.friend_ship_status }.to "requested"
  end
end
