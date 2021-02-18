# frozen_string_literal: true

require "rails_helper"

describe "DELETE /posts/:id", vcr: { record: :once } do
  let(:controller) { PostsController }
  let(:self_peer_info) { create(:peer_info, friend_ship_status: :self, ip: "localhost") }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :accepted) }
  let(:post) { create(:post, uid: "2aab40e432e91fe6a8f5fd5957bf6b3d197b5d7f7825f8a5") }
  let(:url) { "/posts/#{post.id}" }

  before do
    sign_into_controller(controller)
  end

  subject do
    delete url
  end

  it "destroys the post" do
    self_peer_info
    peer_info
    post

    expect do
      subject
    end.to change { Post.count }.by(-1)
      .and change { FeedItem.count }.by(-1)

    expect(response).to have_http_status(:ok)
  end
end
