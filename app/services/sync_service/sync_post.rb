# frozen_string_literal: true

module SyncService
  class SyncPost < BaseSync
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def call_create!
      friends.in_groups_of(10).each do |friend|
        wrap_make_request_thread do
          make_request(:post, build_url_create(friend), body)
        end
      end
    end

    def build_url_create(friend)
      "https://#{friend.ip}/api/sync/feed_item"
    end

    memoize def body
      {
        feed_item: {
          feed_item_type: :post,
          url: api_post_url(post)
        }
      }
    end
  end
end
