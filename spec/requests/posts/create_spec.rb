# frozen_string_literal: true

require "rails_helper"

describe "POST /posts/upload", vcr: { record: :once } do
  include FilesSpecHelper
  let(:controller) { PostsController }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :accepted) }
  let(:url) { "/posts/upload" }
  let(:latest_post) { Post.last }

  before do
    sign_into_controller(controller)
  end

  subject do
    peer_info
    post url, params: params
    SyncService::SyncPost.new(latest_post).call_create!
  end

  context "only with content" do
  end

  context "with images" do
    let(:params) do
      {
        post: {
          content: "new post",
          uploaded_files: [
            {
              ".name": "a.png",
              ".path": sample_image_tmp,
              ".md5": "md5"
            }
          ]
        }
      }
    end

    xit "ok", valid: true do
      expect do
        subject
        expect(response).to have_http_status(:ok)
      end.to change { Post.count }.by(1)
         .and change { ImageFile.count }.by(1)
    end
  end
end
