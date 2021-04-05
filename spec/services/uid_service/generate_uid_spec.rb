# frozen_string_literal: true

require "rails_helper"

describe UidService::GenerateUid do
  include IdentityService::SignedRequest
  let(:post) { build(:post, uid: nil, id: 1) }
  let(:current_peer_info) { create(:peer_info, friend_ship_status: :self, public_key: private_key.public_key.to_pem) }

  subject { described_class.new(post).call! }
  before do
    allow_any_instance_of(described_class).to receive(:is_test?).and_return(false)
  end

  describe "#call!" do
    it "sets the uid" do
      current_peer_info
      subject

      expect(post.uid).to be_present
      post.save!
    end
  end
end
