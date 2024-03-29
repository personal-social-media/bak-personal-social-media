# frozen_string_literal: true

require_relative "./parent_documentation"
require_relative "./update_documentation"
require "rails_helper"

describe "/api/reactions/:id", documentation: true do
  include_context "api_reactions_update"
  include_context "api_reactions"
  include ExternalApiHelpers

  describe "PATCH /api/reactions/:id" do
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
      patch url, params: params
    end

    context "valid", valid: true do
      let(:params) do
        {
          reaction: {
            reaction_type: :love
          }
        }
      end

      it "destroys the reaction" do
        expect do
          subject
          expect(response).to have_http_status(:ok)
          expect(json[:reaction]).to be_present
        end.to change { reaction.reload.reaction_type }
      end
    end
  end
end
