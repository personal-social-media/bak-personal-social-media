# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  metadata          :text             default({}), not null
#  notification_type :string           not null
#  seen              :boolean          default(FALSE), not null
#  subject_type      :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#
# Indexes
#
#  index_notifications_on_subject     (subject_type,subject_id)
#  index_notifications_on_updated_at  (updated_at)
#
FactoryBot.define do
  factory :notification do
    notification_type { :profile_welcome }
    seen { false }
    metadata { {} }

    before(:create) do |r|
      r.subject ||= create(:profile)
    end
  end
end
