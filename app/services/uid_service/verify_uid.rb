# frozen_string_literal: true

module UidService
  class VerifyUid
    attr_reader :feed_item
    def initialize(feed_item)
      @feed_item = feed_item
    end

    def call!
      return if is_test?
      check
    end

    private
      def is_test?
        Rails.env.test?
      end

      def check
        unless PeerInfoService::ValidateSignedContent.new(feed_item.peer_info, uid_decoded, feed_item.uid, decode: true).call!
          errors.add(:uid, :invalid)
        end
      end

      def uid_decoded
        "#{feed_item.feed_item_id}-#{feed_item.feed_item_type}"
      end
  end
end
