# frozen_string_literal: true

describe "/api/friendship" do
  include ExternalApiHelpers
  let(:controller) { Api::FriendshipsController }

  describe "GET /api/friendship" do
    let(:url) { "/api/friendship" }
    let(:peer_info) { create(:peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      peer_info

      get url
    end

    context "exists" do
      it "profile" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:friendship]).to be_present
      end
    end

    context "not existing" do
      let(:peer_info) { nil }
      it "404" do
        subject

        expect(response).to have_http_status(404)
      end
    end
  end
end
