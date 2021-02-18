# frozen_string_literal: true

require "rails_helper"

describe "DELETE /posts/:id", vcr: { record: :once } do
  let(:controller) { PostsController }
  let(:self_peer_info) { create(:peer_info, friend_ship_status: :self, ip: "localhost") }
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :accepted) }
  let(:post) { create(:post, uid: "148760ace40588c347f506e015115a214b9d2cef48c770f9") }
  let(:url) { "/posts/#{post.id}" }

  before do
    sign_into_controller(controller)
  end

  subject do
    self_peer_info
    post
    peer_info

    delete url
  end

  xit "destroys the post" do
    subject

    expect(response).to have_http_status(:ok)
  end
end
