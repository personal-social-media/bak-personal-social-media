# frozen_string_literal: true

require "rails_helper"

describe "/peer_infos/search_public_keys" do
  let(:controller) { PeerInfosController }
  let(:peer_infos) { create_list(:peer_info, 12) }

  describe "POST /peer_infos/search_public_keys" do
    let(:base_url) { "/peer_infos/search_public_keys" }

    subject do
      peer_infos
      sign_into_controller(controller)
      post url, params: { public_keys: peer_infos.first(3).map(&:public_key) }
    end

    context "searches by public keys" do
      let(:url) { base_url }

      it "returns 3 peer_infos" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:peer_infos].size).to eq 3
      end
    end
  end
end
