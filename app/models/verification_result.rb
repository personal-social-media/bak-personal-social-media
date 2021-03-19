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
class VerificationResult < ApplicationRecord
  belongs_to :subject, polymorphic: true
  str_enum :status, %i(running done)
  serialize :result, JSON
  after_commit :run_verification!, on: :create
  validates :subject_id, uniqueness: { scope: :subject_type }

  def run_verification!
    update!(status: :running)

    VerificationResultWorker.perform_async(id)
  end
end
