# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./update_documentation"

describe "/api/comments/:id", documentation: true do
  include ExternalApiHelpers
  include_context "api_comments"
  include_context "api_comments_update"

  describe "PATCH /api/comments/:id" do
    let(:url) { "/api/comments/#{comment.id}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:comment) { create(:comment, peer_info: current_peer_info) }
    let(:post_record) { comment.subject }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(current_peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      patch url, params: params
    end

    context "valid" do
      let(:payload) do
        {
          message: "test",
          subject_id: post_record.uid.to_s,
          subject_type: "Post",
          parent_comment_id: nil,
          images: [
            {
              original: "https://example.com/a.jpg",
              mobile: "https://example.com/a.jpg",
              thumbnail: "https://example.com/a.jpg",
              size: {
                width: "200",
                height: "200",
              }
            }
          ],
          videos: [
            {
              original: "https://example.com/a.mp4",
              original_screenshot: "https://example.com/a.jpg",
              thumbnail_screenshot: "https://example.com/a.jpg",
              short: "https://example.com/a.mp4",
              size: {
                width: "200",
                height: "200",
              }
            }
          ]
        }
      end

      let(:params) do
        {
          comment: {
            payload: payload,
            signature: SignaturesService::Sign.new(payload.to_json).call!
          }
        }
      end

      it "updates the comment", valid: true do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:comment]).to be_present
          comment.reload
        end.to change { comment.signature }
          .and change { comment.payload }
      end
    end
  end
end
