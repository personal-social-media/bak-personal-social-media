describe SetupService::SslCertificate, vcr: { record: :once } do
  subject do
    described_class.new.fetch.write
  end

  it "ok" do
    subject
  end
end