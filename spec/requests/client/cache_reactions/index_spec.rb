# frozen_string_literal: true

require_relative "./index_documentation"
require_relative "./parent_documentation"
require "rails_helper"

describe "POST /client/cache_reactions/search", documentation: true do
  let(:url) { "/client/cache_reactions/search" }
  let(:controller) { Client::CacheReactionsController }
  let(:cache_reactions) { create_list(:cache_reaction, 3) }
  let(:params) do
    {
      search: cache_reactions.map do |reaction|
        reaction.as_json(only: %i(payload_subject_id payload_subject_type))
      end
    }
  end
  include_context "cache_reactions_documentation"
  include_context "cache_reactions_index_documentation"

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "fetches cache reactions", valid: true do
    subject

    expect(response).to have_http_status(:ok)

    expect(json[:cache_reactions]).to be_present
  end
end
