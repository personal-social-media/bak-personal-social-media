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

      put url, params: params
    end

    context "pending" do
      let(:peer_info) { create(:peer_info, friend_ship_status: :pending) }
      before do
        allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      end

      context "accepted" do
        let(:friend_ship_status) { :accepted }
        it "accepts" do
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
          expect(peer_info.reload.accepted?).to be_truthy
        end
      end

      context "declined" do
        let(:friend_ship_status) { :declined }
        it "declins" do
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
          expect(peer_info.reload.declined?).to be_truthy
        end
      end
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
          expect(peer_info.reload.accepted?).to be_falsey
        end
      end
    end
  end
end
