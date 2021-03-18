# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_reactions
#
#  id                   :bigint           not null, primary key
#  payload_subject_type :string           default(""), not null
#  reaction_type        :string           not null
#  subject_type         :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  payload_subject_id   :string           default(""), not null
#  remote_id            :bigint           not null
#  subject_id           :bigint           not null
#
# Indexes
#
#  index_cache_reactions_on_subject  (subject_type,subject_id) UNIQUE
#  payload_index                     (payload_subject_type,payload_subject_id) UNIQUE
#
FactoryBot.define do
  factory :cache_reaction do
    reaction_type { :like }
    sequence(:payload_subject_id) { |n| n }
    sequence(:remote_id) { |i| i }

    payload_subject_type { :post }

    before(:create) do |r|
      r.subject = create(:feed_item) if r.subject_id.blank?
    end
  end
end
