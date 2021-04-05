# frozen_string_literal: true

RSpec.shared_context "api_friendships" do
  let(:documentation_parent_title) { "Friendships" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_friendships }
  let(:controller) { Api::FriendshipsController }
end
