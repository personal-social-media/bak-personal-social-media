# frozen_string_literal: true

require "rails_helper"

describe PostsController, vcr: { record: :once } do
  include FilesSpecHelper
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }

  describe "POST :create" do
    subject do
      peer_info
      login
      post :create, params: { post: post_params }
    end

    context "only content" do
      let(:post_params) do
        {
          content: "new post"
        }
      end

      it "creates a new post" do
        expect do
          subject
        end.to change { Post.count }.by(1)
          .and change { FeedItem.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context "with content and images" do
      let(:post_params) do
        {
          content: "new post",
          uploaded_files: [
            {
              ".name": "a.png",
              ".path": sample_image_tmp,
              ".md5": "md5"
            }
          ]
        }
      end

      it "creates a new post" do
        expect do
          subject
        end.to change { Post.count }.by(1)
        .and change { ImageFile.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
