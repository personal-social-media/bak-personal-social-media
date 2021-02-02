# frozen_string_literal: true

describe "/api/profile" do
  include ExternalApiHelpers
  let(:controller) { Api::ProfilesController }

  describe "GET /api/profile" do
    let(:url) { "/api/profile" }
    before do
      request_as_verified
    end

    subject do
      create(:profile)

      get url
    end

    it "returns the profile" do
      subject

      expect(response).to have_http_status(:ok)
      expect(json[:profile]).to be_present
    end
  end
end
