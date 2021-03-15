# frozen_string_literal: true

require "rails_helper"

describe PeerInfoService::BuildSignature do
  subject do
    described_class.new(create(:peer_info)).call!
  end

  it "creates the signature" do
    expect(subject).to be_present
  end
end
