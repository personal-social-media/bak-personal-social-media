# frozen_string_literal: true

require "rails_helper"

describe "/previous_searches/:id" do
  let(:url) { "/previous_searches/#{previous_search.id}" }
  let(:previous_search) { create(:previous_search) }

  before do
    sign_into_controller(PreviousSearchesController)
  end

  subject do
    delete url
  end

  context "creates a new previous search" do
    it "200" do
      previous_search

      expect do
        subject
      end.to change { PreviousSearch.count }.by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
