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
require "rails_helper"

RSpec.describe CacheComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
