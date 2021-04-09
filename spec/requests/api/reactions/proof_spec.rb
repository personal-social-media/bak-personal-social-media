# frozen_string_literal: true

require_relative "./proof_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "/api/reactions/proof", documentation: true do
  include_context "api_reactions_proof"
  include_context "api_reactions"
  include ExternalApiHelpers

  let(:url) { "/api/reactions/proof" }
  let(:cache_reaction) { create(:cache_reaction) }
  let(:peer_info) { create(:peer_info) }
  let(:params) do
    {
      payload_subject_id: cache_reaction.payload_subject_id,
      payload_subject_type: cache_reaction.payload_subject_type,
    }
  end

  before do
    allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
    request_as_verified
    request_as_server
  end

  subject do
    post url, params: params
  end

  it "ok", valid: true do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:proof]).to be_present
  end
end
