# frozen_string_literal: true

require "rails_helper"

describe "/peer_infos" do
  let(:controller) { PeerInfosController }
  let(:peer_infos) { create_list(:peer_info, 12) }

  describe "GET /peer_infos" do
    let(:base_url) { "/peer_infos" }

    subject do
      peer_infos
      sign_into_controller(controller)
      get url
    end

    context "simple" do
      let(:url) { base_url }

      it "returns 10 peer_infos" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:peer_infos].size).to eq 10
      end
    end

    context "search by name" do
      let(:url) { base_url + "?name_like=name" }

      it "returns 10 peer_infos" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:peer_infos].size).to eq 10
      end
    end

    context "search by ids" do
      let(:url) { base_url + "?peer_ids=#{peer_infos.first(3).map(&:id).join(",")}" }

      it "returns 10 peer_infos" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:peer_infos].size).to eq 3
      end
    end
  end
end
