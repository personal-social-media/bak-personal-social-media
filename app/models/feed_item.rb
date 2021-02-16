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
  str_enum :feed_item_type, %i(post story video_only)
  validates :uid, presence: true, uniqueness: { scope: :peer_info_id }

  if Rails.env.production? && ENV["DEVELOPER"].blank?
    validates :url, url: { schemes: ["https"], no_local: true }
  else
    validates :url, url: true
  end
end
