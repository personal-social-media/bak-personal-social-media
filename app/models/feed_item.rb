# frozen_string_literal: true

# == Schema Information
#
# Table name: feed_items
#
#  id             :bigint           not null, primary key
#  feed_item_type :string           not null
#  uid            :text             not null
#  url            :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  feed_item_id   :bigint           not null
#  peer_info_id   :bigint           not null
#
# Indexes
#
#  feed_items_index_feed_item  (feed_item_type,feed_item_id,peer_info_id) UNIQUE
#  index_feed_items_on_uid     (uid) UNIQUE
#  index_feed_items_on_url     (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
class FeedItem < ApplicationRecord
  belongs_to :peer_info
  str_enum :feed_item_type, %i(post story)
  has_one :cache_reaction, as: :subject, dependent: :destroy
  has_one :cache_comment, as: :subject
  has_many :cache_comments, as: :subject, dependent: :destroy
  has_one :verification_result, as: :subject, dependent: :destroy

  if Rails.env.production? && ENV["DEVELOPER"].blank?
    validates :url, url: { schemes: ["https"], no_local: true }
  else
    validates :url, url: true
  end

  validate :url_matches_peer unless Rails.env.test?
  validate :limit_feed_item_types, on: :create
  validates :uid, presence: true, uniqueness: true
  validate :check_uid, on: :create
  validates :feed_item_type, presence: true
  validates :feed_item_id, presence: true, uniqueness: { scope: %i(feed_item_type peer_info_id) }

  private
    def url_matches_peer
      host = URI.parse(url).host
      errors.add(:url, :invalid, message: "Url mismatch with peer info url") unless host == peer_info.ip
    end

    def limit_feed_item_types
      FeedItemsService::LimitFeedItemTypes.new(self).call!
    end

    def check_uid
      UidService::VerifyUid.new(self).call!
    end
end
