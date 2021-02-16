# frozen_string_literal: true

require "rails_helper"

describe PeerInfoWorker::Ping, vcr: { record: :once } do
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :accepted) }

  subject do
    described_class.new.perform(true)
  end

  it "pings the server" do
    peer_info
    subject

    binding.pry
  end
end
