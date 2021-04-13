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
require "rails_helper"

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
