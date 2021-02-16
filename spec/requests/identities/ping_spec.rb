# frozen_string_literal: true

require "rails_helper"

describe "/identities/ping" do
  include ExternalApiHelpers
  let(:controller) { IdentitiesController }

  describe "POST /identities/ping" do
    let(:headers) { signed_headers(generate_url(url)) }
    let(:url) { "/identities/ping" }
    let(:peer_info) { create(:peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
    end

    subject do
      post url
    end

    it "updates the server_last_seen" do
      expect do
        subject
      end.to change { peer_info.reload.server_last_seen }

      expect(response).to have_http_status(:ok)
    end
  end
end
