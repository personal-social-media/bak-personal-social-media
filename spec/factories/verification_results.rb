# frozen_string_literal: true

# == Schema Information
#
# Table name: verification_results
#
#  id                :bigint           not null, primary key
#  percentage_status :integer          default(0), not null
#  result            :text             default({}), not null
#  status            :string           default("running"), not null
#  subject_type      :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#
# Indexes
#
#  index_verification_results_on_subject  (subject_type,subject_id)
#
FactoryBot.define do
  factory :verification_result do
    before(:create) do |r|
      r.subject ||= create(:feed_item)
    end
  end
end
