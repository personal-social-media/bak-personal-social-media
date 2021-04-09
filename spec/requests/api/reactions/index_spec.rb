# frozen_string_literal: true

require_relative "./index_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "/api/reactions", documentation: true do
  include_context "api_reactions_index"
  include_context "api_reactions"
  include ExternalApiHelpers

  describe "GET /api/reactions?subject_type=:subject_type&subject_id=:subject_id" do
    let(:url) { "/api/reactions?subject_type=post&subject_id=#{post.uid}" }
    let(:current_peer_info) { create(:peer_info, friend_ship_status: :self) }
    let(:peer_info) { create(:peer_info, friend_ship_status: :accepted) }
    let(:post) { create(:post) }
    let(:reactions) { create_list(:reaction, 4, subject: post) }

    before do
      allow_any_instance_of(controller).to receive(:current_peer_info).and_return(peer_info)
      request_as_verified
      current_peer_info
    end

    subject do
      reactions
      get url
    end

    context "valid", valid: true do
      it "returns list of reactions" do
        subject
        expect(response).to have_http_status(:ok)
        expect(json[:reactions]).to be_present
        expect(json[:reactions_count]).to be_present
      end
    end
  end
end
