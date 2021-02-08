# frozen_string_literal: true

require "rails_helper"

describe "/peer_infos" do
  let(:controller) { PeerInfosController }
  let(:peer_info) { build(:peer_info) }

  describe "POST /peer_infos" do
    let(:base_url) { "/peer_infos" }

    subject do
      post url, params: params
    end

    context "creates successfully" do
      let(:url) { base_url }

      let(:params) do
        {
          peer_info: {
            public_key: peer_info.public_key,
            ip: peer_info.ip,
            username: peer_info.username,
            name: peer_info.name,
            avatars: peer_info.avatars
          }
        }
      end

      it "creates a new peer info" do
        sign_into_controller(controller)

        expect { subject }.to change { PeerInfo.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
