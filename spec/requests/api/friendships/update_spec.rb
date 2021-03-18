# frozen_string_literal: true

require "rails_helper"

describe "/api/friendship" do
  include ExternalApiHelpers
  let(:controller) { Api::FriendshipsController }

  describe "PATCH /api/friendship" do
    let(:url) { "/api/friendship" }
    let(:peer_info) { create(:peer_info) }
    let(:params) { { friendship: { friend_ship_status: friend_ship_status } } }

    before do
      request_as_verified
      request_as_server
    end

    subject do
      peer_info
      patch url, params: params
      peer_info.reload
    end

    context "requested" do
      let(:peer_info) { create(:peer_info, friend_ship_status: :requested) }
      before do
        allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      end

      context "accepted" do
        let(:friend_ship_status) { :accepted }
        it "accepts" do
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
          expect(peer_info.accepted?).to be_truthy
        end
      end

      context "declined" do
        let(:friend_ship_status) { :declined }
        it "declines" do
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
          expect(peer_info.declined?).to be_truthy
        end
      end
    end
  end
end
