# frozen_string_literal: true

require "rails_helper"

describe "/previous_searches" do
  let(:url) { "/previous_searches" }

  before do
    sign_into_controller(PreviousSearchesController)
  end

  subject do
    create_list(:previous_search, 10)
    get url
  end

  context "gets some previous_searches" do
    it "200" do
      subject

      expect(response).to have_http_status(:ok)
      expect(json[:previous_searches]).to be_present
    end
  end
end
