# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "/verification_results/:id", documentation: true do
  let(:controller) { VerificationResultsController }
  let(:verification_result) { create(:verification_result) }
  let(:url) { "/verification_results/#{verification_result.id}" }

  include_context "verification_results_documentation"
  include_context "verification_results_update_documentation"

  before do
    allow(VerificationResultWorker).to receive(:perform_async).and_return(true)
    sign_into_controller(controller)
  end

  subject do
    put url
  end

  it "triggers the update", valid: true do
    verification_result.update!(status: :done)
    expect do
      subject
      expect(response).to have_http_status(:ok)
      verification_result.reload
    end.to change { verification_result.status }.to eq("running")
  end
end
