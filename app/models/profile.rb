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
  validates :name, presence: true
  validates :username, presence: true
  validates :gender, presence: true
  auto_strip_attributes :name, :username, squish: true

  str_enum :gender, %i(female male   anything)

  before_create :regenerate_recover_key

  private
    def regenerate_recover_key
      self.recover_key = UserService::RecoverKey.new.call!
    end
end
