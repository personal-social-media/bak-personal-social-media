# frozen_string_literal: true

module FeedItemsService
  class LimitFeedItemTypes
    attr_reader :feed_item
    def initialize(feed_item)
      @feed_item = feed_item
    end

    def call!
      return if peer_info.self?
      check_is_valid_post? if feed_item.post?
    end

    def check_is_valid_post?
      return if FeedItem.where(peer_info_id: feed_item.peer_info_id).where("created_at > ?", 24.hours.ago).count < 4
      errors.add(:peer_info_id, :TOO_MANY)
    end

    delegate :errors, :peer_info, to: :feed_item
  end
end
