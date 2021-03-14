# frozen_string_literal: true

require "rails_helper"

describe "/api/comments" do
  include ExternalApiHelpers
  let(:controller) { Api::CommentsController }

  describe "GET /api/comments?subject_type=:subject_type&subject_id=:subject_id" do
    let(:url) { "/api/comments?subject_type=post&subject_id=#{post.uid}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
    let(:post) { create(:post) }
    let(:comments) { create_list(:comment, 4, subject: post, peer_info: current_peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      current_peer_info
    end

    subject do
      comments
      get url
    end

    context "valid" do
      it "returns list of comments" do
        subject
        expect(response).to have_http_status(:ok)
        expect(json[:comments]).to be_present
        expect(json[:comments_count]).to be_present
      end
    end
  end
end
