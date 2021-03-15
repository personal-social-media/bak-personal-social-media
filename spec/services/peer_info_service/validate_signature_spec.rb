# frozen_string_literal: true

require "rails_helper"

describe PeerInfoService::ValidateSignature do
  include IdentityService::SignedRequest

  let(:peer_info) do
    create(:peer_info, public_key: private_key.public_key.to_pem)
  end

  subject do
    peer_info.send(:set_signature)
    described_class.new(peer_info).call!
  end

  it "verifies the signature" do
    expect(subject).to be_truthy
  end
end
