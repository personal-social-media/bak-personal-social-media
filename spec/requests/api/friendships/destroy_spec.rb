# frozen_string_literal: true

require "rails_helper"

describe "/api/friendship" do
  include ExternalApiHelpers
  let(:controller) { Api::FriendshipsController }

  describe "PUT /api/friendship" do
    let(:url) { "/api/friendship" }
    let(:peer_info) { create(:peer_info) }

    before do
      request_as_verified
      request_as_server
    end

    subject do
      peer_info

      delete url, params: { option: option }
    end

    context "accepted" do
      let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
      before do
        allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      end

      context "accepted" do
        context "destroy" do
          let(:option) { :destroy }
          it "deletes relationship" do
            expect do
              subject
            end.to change { PeerInfo.count }.by(-1)

            expect(response).to have_http_status(:ok)
          end
        end

        context "block" do
          let(:option) { :block }
          it "blocks the relationship" do
            expect do
              subject
            end.to change { peer_info.reload.friend_ship_status }.to "blocked"

            expect(response).to have_http_status(:ok)
          end
        end
      end
    end
  end
end
