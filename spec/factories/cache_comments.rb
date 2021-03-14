# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_comments
#
#  id           :bigint           not null, primary key
#  payload      :text             default("{}"), not null
#  subject_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  remote_id    :bigint           not null
#  subject_id   :bigint           not null
#
# Indexes
#
#  index_cache_comments_on_subject  (subject_type,subject_id)
#
FactoryBot.define do
  factory :cache_comment do
    subject { nil }
    payload { "MyText" }
    remote_id { 1 }
  end
end
