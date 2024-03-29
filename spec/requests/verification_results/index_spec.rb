# frozen_string_literal: true

require "rails_helper"
require_relative "./parent_documentation"
require_relative "./index_documentation"

describe "POST /verification_results/search", documentation: true do
  let(:url) { "/verification_results/search" }
  let(:controller) { VerificationResultsController }
  let(:verification_results) { create_list(:verification_result, 3) }
  include_context "verification_results_documentation"
  include_context "verification_results_index_documentation"

  let(:params) do
    {
      search: verification_results.map do |reaction|
        reaction.as_json(only: %i(remote_type remote_id))
      end
    }
  end

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "fetches verification results", valid: true do
    subject

    expect(response).to have_http_status(:ok)

    expect(json[:verification_results]).to be_present
  end
end
