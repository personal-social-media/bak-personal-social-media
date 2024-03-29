# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "/api/comments", documentation: true do
  include_context "api_comments"
  include_context "api_comments_create"

  include ExternalApiHelpers
  let(:controller) { Api::CommentsController }

  describe "POST /api/comments" do
    let(:url) { "/api/comments" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }
    let(:post_record) { create(:post) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(current_peer_info)
      request_as_verified
      request_as_server
    end

    subject do
      post url, params: params
    end

    context "valid" do
      include_context "api_comments_create"

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
            subject_type: :post,
            subject_id: post_record.uid,
            payload: payload,
            signature: SignaturesService::Sign.new(payload.to_json).call!,
            parent_comment_id: nil
          }
        }
      end

      it "creates a new comment", valid: true do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:comment]).to be_present
        end.to change { current_peer_info.comments.count }.by(1)
      end
    end

    context "invalid wrong key order" do
      let(:payload) do
        {
          message: "test",
          subject_type: "post",
          parent_comment_id: nil,
          subject_id: post_record.uid.to_s,
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
            subject_type: :post,
            subject_id: post_record.uid,
            payload: payload,
            signature: SignaturesService::Sign.new(payload.to_json).call!
          }
        }
      end

      it "nothing" do
        expect do
          subject
          expect(response).to have_http_status(422)
        end.to change { current_peer_info.comments.count }.by(0)
      end
    end

    context "invalid not found" do
      let(:params) do
        {
          comment: {
            subject_type: :post,
            subject_id: "XX",
          }
        }
      end

      it "nothing" do
        expect do
          subject
          expect(response).to have_http_status(404)
        end.to change { current_peer_info.comments.count }.by(0)
      end
    end
  end
end
