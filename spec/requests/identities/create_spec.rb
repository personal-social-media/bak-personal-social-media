# frozen_string_literal: true

require_relative "./create_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "/identities", documentation: true do
  include_context "identities"
  include_context "identities_create"
  include ExternalApiHelpers

  describe "POST /identities" do
    let(:headers) { signed_headers(generate_url(url)) }
    let(:url) { "/identities" }
    let(:params) do
      {
        identity: {
          username: "ok",
          signature: ""
        }
      }
    end

    subject do
      post url, params: params, headers: headers
    end

    context "new" do
      it "creates new peer_info" do
        expect do
          subject
        end.to change { PeerInfo.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context "existing" do
      let(:new_peer) { create(:peer_info, username: "ok", public_key: private_key.public_key.to_pem) }

      it "creates new peer_info", valid: true do
        new_peer

        expect do
          subject
        end.to change { PeerInfo.count }.by(0)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
