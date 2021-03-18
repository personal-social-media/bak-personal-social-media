# frozen_string_literal: true

module SyncService
  class SyncPost < BaseSync
    attr_reader :post, :requests

    def initialize(post)
      @post = post
      @requests = []
    end

    def call_create!
      friends.find_in_batches(batch_size: 200) do |group|
        handle_group(group)
      end

      return unless Rails.env.test?

      requests.each { |r| check_response(r) }
    end

    private
      def handle_group(group)
        hydra = Typhoeus::Hydra.hydra
        @requests += group.map do |peer_info|
          url = "https://#{peer_info.ip}/api/feed_items"
          Typhoeus::Request.new(url, method: :post, headers: default_headers(url), body: body).tap do |r|
            hydra.queue(r)
          end
        end

        hydra.run
      end

      def build_url_create(friend)
        "https://#{friend.ip}/api/sync/feed_item"
      end

      def friends
        PeerInfo.accepted
      end

      memoize def body
        {
          feed_item: {
            feed_item_type: :post,
            url: api_post_url(post),
            uid: post.uid
          }
        }
      end
  end
end
