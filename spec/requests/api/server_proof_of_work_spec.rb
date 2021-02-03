# frozen_string_literal: true

describe "/api/server_proof_of_work" do
  describe "POST /api/server_proof_of_work" do
    let(:url) { "/api/server_proof_of_work" }
    let(:headers) { signed_headers(generate_url(url)) }
    let(:test_string) {  SecureRandom.hex }
    let(:decoded_test_string) { Base32.decode(json[:test][:sign_string]) }
    let(:params) { { test: { sign_string: test_string, multiply: [2, 2] } } }

    subject do
      post url, headers: headers, params: params
    end

    context "ok" do
      it "returns status ok" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json[:test][:multiply]).to eq 4
        expect(private_key.verify(OpenSSL::Digest::SHA256.new, decoded_test_string, test_string))
      end
    end
  end
end
