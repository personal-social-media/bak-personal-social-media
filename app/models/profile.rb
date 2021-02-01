# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id                :bigint           not null, primary key
#  gender            :string           not null
#  name              :text             not null
#  recover_key       :text             not null
#  recover_key_saved :boolean          default(FALSE), not null
#  username          :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Profile < ApplicationRecord
  extend Memoist
  validates :name, presence: true
  validates :username, presence: true
  validates :gender, presence: true
  has_one :profile_picture_attachment, class_name: "AttachedFile", dependent: :destroy, as: :subject
  has_one :profile_image, through: :profile_picture_attachment, source_type: "ImageFile", source: :attachment
  auto_strip_attributes :name, :username, squish: true

  str_enum :gender, %i(female male agender genderqueer nonbinary other)

  before_create :regenerate_recover_key
  after_create :create_peer_info

  memoize def peer_info
    PeerInfo.find_by(friend_ship_status: :self)
  end

  private
    def regenerate_recover_key
      self.recover_key = UserService::RecoverKey.new.call!
    end

    def create_peer_info
      ProfileService::CreatePeerInfo.new(self).call!
    end
end
