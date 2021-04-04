# frozen_string_literal: true

RSpec.shared_context "friendships_documentation" do
  let(:documentation_parent_title) { "Friendships" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :client_friendships  }
  let(:controller) { Client::FriendshipsController }
end
