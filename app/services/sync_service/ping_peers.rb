# frozen_string_literal: true

module SyncService
  class PingPeers < BaseSync
    def call!
      PeerInfo.not_blocked.not_self.find_in_batches(batch_size: 200) do |group|
        handle_group(group)
      end
    end

    private
      def handle_group(group)
        hydra = Typhoeus::Hydra.hydra
        requests = group.map do |peer_info|
          url = "https://#{peer_info.ip}/identities/peer"
          Typhoeus::Request.new(url, method: :post, headers: default_headers(url)).tap do |r|
            hydra.queue(r)
          end
        end

        hydra.run
        requests
      end
  end
end
