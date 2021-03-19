# frozen_string_literal: true

# == Schema Information
#
# Table name: feed_items
#
#  id             :bigint           not null, primary key
#  feed_item_type :string           not null
#  uid            :string
#  url            :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  peer_info_id   :bigint           not null
#
# Indexes
#
#  index_feed_items_on_peer_info_id_and_uid  (peer_info_id,uid) UNIQUE
#  index_feed_items_on_url                   (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
class FeedItem < ApplicationRecord
  belongs_to :peer_info
  str_enum :feed_item_type, %i(post story)
  validates :uid, presence: true, uniqueness: { scope: :peer_info_id }
  has_one :cache_reaction, as: :subject, dependent: :destroy
  has_one :verification_result, as: :subject, dependent: :destroy

  if Rails.env.production? && ENV["DEVELOPER"].blank?
    validates :url, url: { schemes: ["https"], no_local: true }
  else
    validates :url, url: true
  end

  validate :url_matches_peer unless Rails.env.test?
  validate :limit_feed_item_types # , on: :create

  def url_matches_peer
    host = URI.parse(url).host
    errors.add(:url, :invalid, message: "Url mismatch with peer info url") unless host == peer_info.ip
  end

  def limit_feed_item_types
    FeedItemsService::LimitFeedItemTypes.new(self).call!
  end
end
