# frozen_string_literal: true

require "rails_helper"

describe "/previous_searches" do
  let(:url) { "/previous_searches" }
  let(:peer_info) { create(:peer_info) }
  let(:params) do
    {
      peer_info: {
        id: peer_info.id
      }
    }
  end

  before do
    sign_into_controller(PreviousSearchesController)
  end

  subject do
    post url, params: params
  end

  context "creates a new previous search" do
    it "200" do
      expect do
        subject
      end.to change { PreviousSearch.count }.by(1)

      expect(response).to have_http_status(:ok)
      expect(json[:previous_search]).to be_present
    end
  end
end
