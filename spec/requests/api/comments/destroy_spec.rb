# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./destroy_documentation"

describe "/api/comments/:id", documentation: true do
  include_context "api_comments_destroy"
  include_context "api_comments"
  include ExternalApiHelpers

  describe "DELETE /api/comments/:id" do
    let(:url) { "/api/comments/#{comment.id}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:comment) { create(:comment, peer_info: current_peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(current_peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      delete url
    end

    it "destroys the comment", valid: true do
      comment

      expect do
        subject
        expect(response).to have_http_status(:ok)
      end.to change { Comment.count }.by(-1)
    end
  end
end
