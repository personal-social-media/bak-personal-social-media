# frozen_string_literal: true

module SyncService
  class SyncPeerInfo < BaseSync
    attr_reader :peer_info, :response

    def initialize(peer_info)
      @peer_info = peer_info
    end

    def call!
      propagate_to_registry
      propagate_to_friends
    end

    def propagate_to_friends
      peer_info_body
      add_friend_fields

      PeerInfo.not_blocked.not_self.find_in_batches(batch_size: 200) do |group|
        handle_group(group)
      end
    end

    def propagate_to_registry
      url = "https://registry.personalsocialmedia.net/identities"
      hydra = Typhoeus::Hydra.hydra
      request = Typhoeus::Request.new(url, method: :post, headers: default_headers(url), body: peer_info_body)
      hydra.queue(request)
      hydra.run

      check_response(request)
      response = request.response
      JSON.parse(response.body)
    end

    private
      def handle_group(group)
        hydra = Typhoeus::Hydra.hydra
        requests = group.map do |peer_info|
          url = "https://#{peer_info.ip}/identities"
          Typhoeus::Request.new(url, method: :post, headers: default_headers(url), body: peer_info_body).tap do |r|
            hydra.queue(r)
          end
        end

        hydra.run
        requests
      end

      def peer_info_body
        @peer_info_body ||= {
          identity: {
            username: peer_info.username,
            name: peer_info.name,
            avatars: peer_info.avatars,
          }
        }
      end

      def add_friend_fields
        @peer_info_body[:identity].merge(
          city_name: peer_info.city_name,
          country_code: peer_info.country_code,
          about: peer_info.about,
        )
      end
  end
end
