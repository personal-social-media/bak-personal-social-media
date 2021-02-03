# frozen_string_literal: true

describe SyncService::SyncPeerInfo, vcr: { record: :once } do
  let(:peer_info) { create(:peer_info) }

  describe "#propagate_to_registry" do
    subject do
      described_class.new(peer_info).propagate_to_registry
    end

    it "ok" do
      expect(subject["identity"]).to be_present
    end
  end
end
