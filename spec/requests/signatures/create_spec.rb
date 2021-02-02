# frozen_string_literal: true

describe "/sign" do
  let(:url) { "/sign" }
  let(:result) { json[:result] }

  before do
    sign_into_controller(SignaturesController)
  end

  subject do
    post url, params: params
  end

  context "text" do
    let(:params) { { content: { url: "https://google.com" } } }

    it "200" do
      subject

      expect(response).to have_http_status(:ok)
      expect(verify_with_private_key(result, params[:content][:url])).to be_truthy
    end
  end

  context "text" do
    let(:params) { { content: { text: "my content" } } }

    it "200" do
      subject

      expect(response).to have_http_status(:ok)
      expect(verify_with_private_key(result, params[:content][:text])).to be_truthy
    end
  end
end
