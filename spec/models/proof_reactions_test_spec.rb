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
require "rails_helper"

RSpec.describe ProofReactionsTest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
