# frozen_string_literal: true

require "rails_helper"

describe PeerInfoWorker::Ping, vcr: { record: :once } do
  let(:peer_info) { create(:peer_info, ip: "161.97.64.223", friend_ship_status: :accepted) }
  let(:requests) { subject.requests }

  subject do
    described_class.new.perform(true)
  end

  it "pings the server" do
    peer_info
    subject

    expect(requests.size).to eq 1
    requests.each do |r|
      subject.check_response(r)
    end
  end
end
