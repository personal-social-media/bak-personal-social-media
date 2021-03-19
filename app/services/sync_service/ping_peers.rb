# frozen_string_literal: true

module SyncService
  class PingPeers < BaseSync
    attr_reader :requests, :time

    def initialize
      @time = Time.zone.now
      @requests = []
    end

    def call!
      PeerInfo.not_blocked.not_self.find_in_batches(batch_size: 200) do |group|
        handle_group(group)
        update_peer_infos!
      end
    end

    private
      def handle_group(group)
        hydra = Typhoeus::Hydra.hydra
        @requests += group.map do |peer_info|
          url = "https://#{peer_info.ip}/identities/ping"
          request = Typhoeus::Request.new(url, method: :post, headers: default_headers(url)).tap do |r|
            hydra.queue(r)
          end

          {
            peer_info: peer_info, request: request
          }
        end

        hydra.run
      end

      def update_peer_infos!
        valid_requests = requests.select do |r|
          r[:request].response.code < 400
        end

        peer_info_ids = valid_requests.map do |r|
          r[:peer_info].id
        end

        PeerInfo.where(id: peer_info_ids).update_all(server_last_seen: time)
      end
  end
end
