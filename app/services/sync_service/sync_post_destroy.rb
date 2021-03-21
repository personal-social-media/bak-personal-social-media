# frozen_string_literal: true

module SyncService
  class SyncPostDestroy < BaseSync
    include AsyncService::RunAsync
    attr_reader :post_uid, :peer_requests

    def initialize(post_uid)
      @post_uid = post_uid
      @peer_requests = []
    end

    def call_destroy!
      friends.find_in_batches(batch_size: 200) do |group|
        @peer_requests += handle_group(group)
      end

      return unless Rails.env.test?

      peer_requests.each { |r| check_response(r) }
    end

    private
      def handle_group(group)
        hydra = Typhoeus::Hydra.hydra
        requests = group.map do |peer_info|
          url = "https://#{peer_info.ip}/api/feed_items/#{post_uid}"
          Typhoeus::Request.new(url, method: :delete, headers: default_headers(url)).tap do |r|
            hydra.queue(r)
          end
        end

        hydra.run if requests.present?
        requests
      end

      def friends
        PeerInfo.accepted
      end
  end
end
