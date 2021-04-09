# frozen_string_literal: true

require_relative "./ping_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "/identities/ping", documentation: true do
  include_context "identities_ping"
  include_context "identities"
  include ExternalApiHelpers

  describe "POST /identities/ping" do
    let(:headers) { signed_headers(generate_url(url)) }
    let(:url) { "/identities/ping" }
    let(:peer_info) { create(:peer_info) }
    let(:params) { {} }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
    end

    subject do
      post url
      peer_info.reload
    end

    it "updates the server_last_seen", valid: true do
      expect do
        subject
        expect(response).to have_http_status(:ok)
      end.to change { peer_info.server_last_seen }
    end
  end
end
