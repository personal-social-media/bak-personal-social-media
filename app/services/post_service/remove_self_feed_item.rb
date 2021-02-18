# frozen_string_literal: true

module PostService
  class RemoveSelfFeedItem
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def call!
      peer_info.feed_items.find_by!(uid: post.uid).destroy
    end

    private
      def peer_info
        PeerInfo.find_by(friend_ship_status: :self)
      end
  end
end
