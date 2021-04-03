# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./show_documentation"

describe "/verification_results/:id", documentation: true do
  let(:verification_result) { create(:verification_result) }
  let(:url) { "/verification_results/#{verification_result.id}" }
  include_context "verification_results_documentation"
  include_context "verification_results_show_documentation"

  before do
    allow(VerificationResultWorker).to receive(:perform_async).and_return(true)
    sign_into_controller(controller)
  end

  subject do
    get url
  end

  it "triggers the update", valid: true do
    subject
    expect(response).to have_http_status(:ok)
    expect(json[:verification_result]).to be_present
  end
end
