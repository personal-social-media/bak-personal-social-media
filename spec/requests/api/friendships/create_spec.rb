# frozen_string_literal: true

describe "/api/friendship" do
  include ExternalApiHelpers
  let(:controller) { Api::FriendshipsController }

  describe "POST /api/friendship" do
    let(:url) { "/api/friendship" }
    let(:peer_info) { create(:peer_info) }

    before do
      request_as_verified
      request_as_server
    end

    subject do
      peer_info

      post url
    end

    context "exists" do
      let(:peer_info) { create(:peer_info) }
      before do
        allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      end

      it "profile" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:friendship]).to be_present
      end
    end

    context "new" do
      before do
        allow_any_instance_of(FriendshipService::Create).to receive(:public_key).and_return(:key)
      end

      context "brand new" do
        it "profile" do
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
        end
      end

      context "existing UNKNOWN" do
        let(:peer_info) { create(:peer_info, username: "UNKNOWN") }
        before do
          allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
          allow_any_instance_of(PeerInfo).to receive(:fetch_more_information)
        end

        it "profile" do
          peer_info
          subject

          expect(response).to have_http_status(:ok)
          expect(json[:friendship]).to be_present
          expect(peer_info.reload.requested?).to be_truthy
        end
      end
    end
  end
end
