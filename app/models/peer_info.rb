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
#  friend_ship_status :string
#  ip                 :string           not null
#  name               :text
#  public_key         :text             not null
#  server_last_seen   :datetime
#  signature          :text             default(""), not null
#  username           :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_peer_infos_on_city_name        (city_name)
#  index_peer_infos_on_country_code     (country_code)
#  index_peer_infos_on_name             (name) USING gin
#  index_peer_infos_on_public_key       (public_key) UNIQUE
#  index_peer_infos_on_username_and_ip  (username,ip)
#
class PeerInfo < ApplicationRecord
  scope :name_similar, ->(name) do
    quoted_name = ActiveRecord::Base.connection.quote_string(name)
    where("name % ?", name).
      order(Arel.sql("similarity(name, '#{quoted_name}') DESC"))
  end

  scope :active, -> do
    where(friend_ship_status: %i(active pending_accept))
  end

  scope :not_blocked, -> do
    where.not(friend_ship_status: :blocked)
  end

  scope :not_self, -> do
    where.not(friend_ship_status: :self)
  end

  str_enum :friend_ship_status, %i(requested pending_accept declined self stranger accepted blocked)
  after_commit :fetch_more_information, on: :create, if: -> { friend_ship_status != "self" } if Rails.env.production?
  after_commit :propagate_updates, on: %i(create update), if: -> { friend_ship_status == "self" } if Rails.env.production?
  before_validation :set_signature, if: -> { friend_ship_status == "self" } if Rails.env.production?

  if Rails.env.production? && ENV["DEVELOPER"].blank?
    validates :ip, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }
  end

  validates :username, exclusion: { in: %w(UNKNOWN) }, on: :update
  validates :country_code, inclusion: { in: ISO3166::Country.translations.keys }, if: -> { country_code.present? }
  validates :public_key, presence: true, uniqueness: true
  validates :about, allow_blank: true, length: { maximum: 2000 }
  validates :signature, presence: true if Rails.env.production?
  validate :is_public_key_for_real, on: :create, if: -> { friend_ship_status != "self" } if Rails.env.production? && ENV["DEVELOPER"].blank?
  if Rails.env.production?
    validate :validate_signature
    validate :validate_public_key, on: :create
  end

  has_many :feed_items, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_one :conversation, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :previous_searches, dependent: :destroy
  has_many :cache_comments, dependent: :destroy
  has_many :cache_reactions, dependent: :destroy
  has_many :verification_results, dependent: :destroy
  has_many :notifications, as: :subject, dependent: :destroy
  has_many :cache_focus_subscriptions, dependent: :delete_all
  has_many :focus_subscriptions, dependent: :delete_all
  has_many :group_memberships, dependent: :destroy
  serialize :avatars, JSON

  def fetch_more_information
    PeerInfoWorker::FetchInfo.perform_async(id)
  end

  def propagate_updates
    PeerInfoWorker::PropagateChanges.perform_async(id)
  end

  def is_public_key_for_real
    errors.add(:public_key, :invalid, message: "Fake public key") unless IdentityService::CheckPublicKey.new(public_key, ip).call!
  end

  private
    def set_signature
      self.signature = PeerInfoService::BuildSignature.new(self).call!
    end

    def validate_signature
      errors.add(:signature, :invalid) unless PeerInfoService::ValidateSignature.new(self).call!
    end

    def validate_public_key
      self.public_key = OpenSSL::PKey::RSA.new(public_key).to_s
    rescue OpenSSL::PKey::RSAError
      errors.add(:public_key, :invalid)
    end
end
