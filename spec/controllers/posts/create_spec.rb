# frozen_string_literal: true

require "rails_helper"

describe PostsController do
  include FilesSpecHelper

  describe "POST :create" do
    subject do
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

        expect(response).to have_http_status(:ok)
      end
    end

    context "with content and images" do
      let(:post_params) do
        {
          content: "new post",
          files: [
            Rack::Test::UploadedFile.new(sample_image)
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
