# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./public_key_documentation"
require "rails_helper"

describe "/public_key", documentation: true do
  include ExternalApiHelpers
  include_context "static_documentation"
  include_context "static_public_key_documentation"
  let(:url) { "/public_key" }

  before do
    request_as_verified
  end

  subject do
    get url
  end

  it "returns the public key", valid: true do
    subject

    expect(response).to have_http_status(:ok)
  end
end
