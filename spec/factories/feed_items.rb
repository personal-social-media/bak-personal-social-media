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
FactoryBot.define do
  factory :feed_item do
    feed_item_type { :post }
    uid { "UID-#{SecureRandom.hex}" }
    sequence :feed_item_id do |n|
      n
    end

    before(:create) do |r|
      r.peer_info ||= create(:peer_info)
      r.url = "https://#{r.peer_info.ip}/#{SecureRandom.hex}"
    end
  end
end
