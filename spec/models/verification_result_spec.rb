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
require "rails_helper"

RSpec.describe VerificationResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
