# frozen_string_literal: true

require "rails_helper"

describe IdentityService::CheckPublicKey, vcr: { record: :once } do
  let(:public_key) do
    <<-TXT
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsDb+Etz52K21M/NshvTJ
/436gOi3J6aF7d2iGGtztae1XtvaP6c5YP7qcv9aHF3JPgnRsDGLbQvKXxIIzrsa
/rre6qD6Sg6gV9TV56ews1rcZ6GHM+bWT9hHwdGovU0o50529G313eNMFfAly54k
754No3JlQI5vxkP9XRGdFh7z3EgoRQpv4iGxV9VnaRO0xT9OGMTnzfpNjSWLEEwN
FUXoA5El484OITk/oqfTKO9KjINbCR38wZWhfNOjRF8/p1hM0lxaHEqdBRjifONI
NF30WUR962uQ4GVG73W2oxPc8BDJ24J/XMwbJtdR/vRjQ4m78tuuil5Yn3Rse5Qk
CQIDAQAB
-----END PUBLIC KEY-----
    TXT
  end

  subject do
    described_class.new(public_key, "161.97.64.223").call!
  end

  it "ok" do
    expect(subject).to be_truthy
  end
end
