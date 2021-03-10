# frozen_string_literal: true

require "rails_helper"

describe "/api/reactions" do
  include ExternalApiHelpers
  let(:controller) { Api::ReactionsController }

  describe "POST /api/reactions" do
    let(:url) { "/api/reactions" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self) }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
    let(:post_record) { create(:post) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
      current_peer_info
    end

    subject do
      post url, params: params
    end

    context "valid" do
      let(:params) do
        {
          reaction: {
            subject_type: :post,
            subject_id: post_record.uid,
            reaction_type: :like
          }
        }
      end

      it "creates a new reaction" do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:reaction]).to be_present
        end.to change { peer_info.reactions.count }.by(1)
      end
    end

    context "invalid already created" do
      let(:params) do
        {
          reaction: {
            subject_type: :post,
            subject_id: post_record.uid,
            reaction_type: :like
          }
        }
      end

      it "nothing" do
        create(:reaction, peer_info: peer_info, reaction_type: :like, subject: post_record)

        expect do
          subject
          expect(response).to have_http_status(422)
        end.to change { peer_info.reactions.count }.by(0)
      end
    end

    context "invalid not found" do
      let(:params) do
        {
          reaction: {
            subject_type: :post,
            subject_id: "XX",
            reaction_type: :like
          }
        }
      end

      it "nothing" do
        expect do
          subject
          expect(response).to have_http_status(404)
        end.to change { peer_info.reactions.count }.by(0)
      end
    end
  end
end
