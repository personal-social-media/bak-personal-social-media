# frozen_string_literal: true

require "rails_helper"

describe "/verification_results/:id" do
  let(:controller) { VerificationResultsController }
  let(:verification_result) { create(:verification_result) }
  let(:url) { "/verification_results/#{verification_result.id}" }

  before do
    allow(VerificationResultWorker).to receive(:perform_async).and_return(true)
    sign_into_controller(controller)
  end

  subject do
    put url
  end

  it "triggers the update" do
    verification_result.update!(status: :done)
    expect do
      subject
      expect(response).to have_http_status(:ok)
      verification_result.reload
    end.to change { verification_result.status }.to eq("running")
  end
end
