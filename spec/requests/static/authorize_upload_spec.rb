# frozen_string_literal: true

require "rails_helper"

describe "/authorize_upload" do
  let(:controller) { StaticController }

  before do
    sign_into_controller(controller)
  end

  subject do
    get "/authorize_upload"
  end

  it "authorizes the upload" do
    subject

    expect(response).to have_http_status(:ok)
  end
end
