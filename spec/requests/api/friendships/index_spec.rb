# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./index_documentation"
require "rails_helper"

describe "/api/friendships", documentation: true do
  include_context "api_friendships_index"
  include_context "api_friendships"
  include ExternalApiHelpers

  describe "GET /api/friendships" do
    let(:url) { "/api/friendships" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
    let(:post) { create(:post) }
    let(:friendships) { create_list(:peer_info, 4, friend_ship_status: :accepted) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      current_peer_info
    end

    subject do
      friendships
      get url
    end

    context "valid", valid: true do
      it "returns list of friendships" do
        subject
        expect(response).to have_http_status(:ok)
        expect(json[:friendships]).to be_present
        expect(json[:friendships_count]).to be_present
      end
    end
  end
end
