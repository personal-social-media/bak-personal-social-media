# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./destroy_documentation"
require "rails_helper"

describe "/api/reactions/:id", documentation: true do
  include_context "api_reactions_destroy"
  include_context "api_reactions"
  include ExternalApiHelpers

  describe "DELETE /api/reactions/:id" do
    let(:url) { "/api/reactions/#{reaction.id}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self) }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
    let(:reaction) { create(:reaction, peer_info: peer_info) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      request_as_server
      current_peer_info
    end

    subject do
      delete url
    end

    it "destroys the reaction", valid: true do
      reaction

      expect do
        subject
        expect(response).to have_http_status(:ok)
      end.to change { Reaction.count }.by(-1)
    end
  end
end
