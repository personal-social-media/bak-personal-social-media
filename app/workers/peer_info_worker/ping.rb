# frozen_string_literal: true

module PeerInfoWorker
  class Ping < ApplicationWorker
    include WorkersService::RandomScheduled

    def random_delay
      24.hours
    end

    def random_perform
      SyncService::PingPeers.new.tap do |ping_peers|
        ping_peers.call!
      end
    end
  end
end
