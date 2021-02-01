# frozen_string_literal: true

module PostService
  class CreateSelfFeedItem
    include Rails.application.routes.url_helpers
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def call!
      FeedItem.create!(feed_item_type: :post, uid: post.uid, url: api_post_url(post), peer_info: peer_info)
    end

    private
      def peer_info
        PeerInfo.find_by(friend_ship_status: :self)
      end
  end
end
