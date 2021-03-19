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
    get url
  end

  it "triggers the update" do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:verification_result]).to be_present
  end
end
