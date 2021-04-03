# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./create_documentation"
require "rails_helper"

describe "/verification_results", documentation: true do
  let(:url) { "/verification_results" }
  let(:peer_info) { create(:peer_info, friend_ship_status: :accepted, ip: "161.97.64.223") }
  let(:uid) { "76e895ca6549958cfa5662d372b7e7538724df06f67ab531" }
  let(:feed_item) { create(:feed_item, peer_info: peer_info, feed_item_type: :post, uid: uid) }
  include_context "verification_results_documentation"
  include_context "verification_results_create_documentation"

  let(:params) do
    {
      verification_result: {
        remote_id: uid,
        remote_type: :post,
        peer_info_id: peer_info.id
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

  it "creates a new verification_result", valid: true do
    feed_item

    expect do
      subject
      expect(response).to have_http_status(:ok)
      expect(json[:verification_result]).to be_present
    end.to change { VerificationResult.count }.by(1)
  end
end
