# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./show_documentation"
require "rails_helper"

describe "/api/comments/:id", documentation: true do
  include_context "api_comments_show"
  include_context "api_comments"
  include ExternalApiHelpers

  describe "GET /api/comments/:id" do
    let(:url) { "/api/comments/#{comment.id}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:comment) { create(:comment, peer_info: current_peer_info) }
    let(:post_record) { comment.subject }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(current_peer_info)
      request_as_verified
    end

    subject do
      get url
    end

    it "gets the comment", valid: true do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:comment]).to be_present
    end
  end
end
