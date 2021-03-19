# frozen_string_literal: true

class VerificationResultWorker < ApplicationWorker
  attr_reader :verification

  def perform(verification_id)
    @verification = VerificationResult.find_by(id: verification_id)
  end
end
