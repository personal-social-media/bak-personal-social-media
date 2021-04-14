# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id                           :bigint           not null, primary key
#  about                        :text
#  city_name                    :text
#  country_code                 :string
#  gender                       :string           not null
#  last_seen_at                 :datetime         not null
#  name                         :text             not null
#  not_seen_notifications_count :bigint           default(0), not null
#  recovery_key_digest          :text
#  recovery_key_plain           :text
#  unread_messages_count        :bigint           default(0), not null
#  username                     :string           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class Profile < ApplicationRecord
  extend Memoist
  has_secure_password :recovery_key
  validates :name, presence: true
  validates :username, presence: true
  validates :gender, presence: true
  validates :country_code, inclusion: { in: ISO3166::Country.translations.keys }, if: -> { country_code.present? }
  validates :about, allow_blank: true, length: { maximum: 2000 }
  has_many :notifications, as: :subject, dependent: :delete_all
  has_one :profile_picture_attachment, -> { where(attachment_type: "ImageFile") }, class_name: "AttachedFile", dependent: :destroy, as: :subject
  has_one :profile_video_attachment, -> { where(attachment_type: "VideoFile") }, class_name: "AttachedFile", dependent: :destroy, as: :subject
  has_one :profile_image, through: :profile_picture_attachment, source_type: "ImageFile", source: :attachment
  has_one :profile_video, through: :profile_video_attachment, source_type: "VideoFile", source: :attachment
  auto_strip_attributes :name, :username, squish: true
  before_save { username.downcase! }

  str_enum :gender, %i(female male agender genderqueer nonbinary other)

  before_validation :regenerate_recovery_key, on: :create
  after_create :create_peer_info
  after_create :create_settings unless Rails.env.test?
  after_create :create_welcome_notification unless Rails.env.test?

  memoize def peer_info
    PeerInfo.find_by(friend_ship_status: :self)
  end

  memoize def current_avatar
    profile_video_attachment || profile_picture_attachment
  end

  def attachments_ready!
    ProfileService::AttachmentsReady.new(self).call!
  end

  def regenerate_recovery_key
    UserService::RecoverKey.new.call!.tap do |key|
      self.recovery_key = key
      self.recovery_key_plain = key
    end
  end

  private
    def create_peer_info
      ProfileService::CreatePeerInfo.new(self).call!
    end

    def create_settings
      ProfileService::CreateSettings.new.call!
    end

    def create_welcome_notification
      Notification.create!(subject: self, notification_type: :profile_welcome)
    end
end
