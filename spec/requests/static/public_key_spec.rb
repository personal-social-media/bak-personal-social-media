# frozen_string_literal: true

describe "/public_key" do
  subject do
    get "/public_key"
  end

  it "returns the public key" do
    subject

    expect(response).to have_http_status(:ok)
  end
end
