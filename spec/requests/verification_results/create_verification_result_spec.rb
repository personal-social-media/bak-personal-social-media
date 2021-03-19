# frozen_string_literal: true

require "rails_helper"

describe "/verification_results" do
  let(:controller) { VerificationResultsController }
  let(:url) { "/verification_results" }
  let(:feed_item) { create(:feed_item) }
  let(:params) do
    {
      verification_result: {
        subject_id: feed_item.id,
        subject_type: "FeedItem"
      }
    }
  end

  before do
    allow(VerificationResultWorker).to receive(:perform_async).and_return(true)
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "creates a new verification_result" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:verification_result]).to be_present
    end.to change { VerificationResult.count }.by(1)
  end
end
