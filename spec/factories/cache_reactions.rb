# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_reactions
#
#  id            :bigint           not null, primary key
#  reaction_type :string           not null
#  subject_type  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  remote_id     :bigint           not null
#  subject_id    :bigint           not null
#
# Indexes
#
#  index_cache_reactions_on_subject  (subject_type,subject_id) UNIQUE
#
FactoryBot.define do
  factory :cache_reaction do
    reaction_type { :like }
    sequence(:remote_id) { |i| i }

    before(:create) do |r|
      r.subject = create(:feed_item) if r.subject_id.blank?
    end
  end
end
