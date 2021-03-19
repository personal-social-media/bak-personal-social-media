# frozen_string_literal: true

require "rails_helper"

describe "POST /client/cache_reactions/search" do
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

  before do
    sign_into_controller(controller)
  end

  subject do
    post url, params: params
  end

  it "fetches cache reactions", skip_propsite: true do
    subject

    expect(response).to have_http_status(:ok)

    expect(json[:cache_reactions]).to be_present
  end
end
