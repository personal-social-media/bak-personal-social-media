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
FactoryBot.define do
  factory :feed_item do
    feed_item_type { :post }
    uid { SecureRandom.hex }

    before(:create) do |r|
      r.peer_info ||= create(:peer_info)
      r.url = "https://#{r.peer_info.ip}/"
    end
  end
end
