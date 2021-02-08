# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_infos
#
#  id                 :bigint           not null, primary key
#  about              :text
#  avatars            :text
#  city_name          :text
#  country_code       :string
#  friend             :boolean          default(FALSE), not null
#  friend_ship_status :string
#  ip                 :string           not null
#  name               :text
#  public_key         :text             not null
#  username           :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_peer_infos_on_city_name        (city_name)
#  index_peer_infos_on_country_code     (country_code)
#  index_peer_infos_on_name             (name) USING gin
#  index_peer_infos_on_username_and_ip  (username,ip)
#
class PeerInfo < ApplicationRecord
  str_enum :friend_ship_status, %i(requested pending declined self accepted blocked)
  after_commit :fetch_more_information, on: :create, if: -> { friend_ship_status != "self" } if Rails.env.production?
  after_commit :propagate_updates, on: %i(create update), if: -> { friend_ship_status == "self" } if Rails.env.production?

  validates :username, exclusion: { in: %w(UNKNOWN) }, on: :update
  validates :country_code, inclusion: { in: ISO3166::Country.translations.keys }, if: -> { country_code.present? }

  def fetch_more_information
    PeerInfoWorker::FetchInfo.perform_async(id)
  end

  def propagate_updates
    PeerInfoWorker::PropagateChanges.perform_async(id)
  end

  serialize :avatars, JSON
end
