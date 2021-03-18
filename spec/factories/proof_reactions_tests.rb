# frozen_string_literal: true

# == Schema Information
#
# Table name: proof_reactions_tests
#
#  id           :bigint           not null, primary key
#  result       :text             default("{}"), not null
#  subject_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint           not null
#
# Indexes
#
#  index_proof_reactions_tests_on_subject  (subject_type,subject_id)
#
FactoryBot.define do
  factory :proof_reactions_test do
    subject { nil }
    result { "MyText" }
  end
end
