# frozen_string_literal: true

describe "/api/friendship" do
  include ExternalApiHelpers
  let(:controller) { Api::FriendshipsController }

  describe "PUT /api/friendship" do
    let(:url) { "/api/friendship" }
    let(:peer_info) { create(:peer_info) }
    let(:params) { { friendship: { friend_ship_status: friend_ship_status } } }

    before do
      request_as_verified
      request_as_server
    end

    subject do
      peer_info

      delete url
    end

    context "accepted" do
      let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
      before do
        allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      end

      context "accepted" do
        it "deletes relationship" do
          expect do
            subject
          end.to change { PeerInfo.count }.by(-1)

          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
