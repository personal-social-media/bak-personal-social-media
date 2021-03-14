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
class CacheComment < ApplicationRecord
  belongs_to :subject, polymorphic: true
end
