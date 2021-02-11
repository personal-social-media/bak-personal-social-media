# frozen_string_literal: true

require "rails_helper"

describe "/public_key" do
  include ExternalApiHelpers
  let(:controller) { StaticController }

  before do
    request_as_verified
  end

  subject do
    get "/public_key"
  end

  it "returns the public key" do
    subject

    expect(response).to have_http_status(:ok)
  end
end
