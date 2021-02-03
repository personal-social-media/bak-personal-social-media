# frozen_string_literal: true

module SyncService
  class SyncPeerInfo < BaseSync
    def initialize(peer_info)
      @peer_info = peer_info
    end

    def call!
      propagate_to_registry
      add_friend_fields

      PeerInfo.find_in_batches(batch_size: 20) do |group|
        handle_group(group)
      end
    end

    private

    def handle_group(group)
      group.each do |peer_info|
        wrap_make_request_thread do
          url = build_url(peer_info)
          make_request(:post, url, peer_info_body)
        end
      end
    end

    def propagate_to_registry
      url = "https://registry.personalsocialmedia.net/"
      wrap_make_request_thread do
        make_request(:post, url, peer_info_body)
      end
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

    def build_url(peer_info)
      peer_info.ip + "/api/sync_peer"
    end
  end
end
