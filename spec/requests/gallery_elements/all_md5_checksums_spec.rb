# frozen_string_literal: true

require "rails_helper"

describe "GET /gallery_elements/all_md5_checksums" do
  let(:url) { "/gallery_elements/all_md5_checksums" }
  let(:image_files) { create_list(:image_file, 2, private: true, md5_checksum: "1234") }

  before do
    sign_into_controller(GalleryElementsController)
    allow_any_instance_of(ImagesService::AddMetadataToImage).to receive(:allow_call?).and_return true
  end

  subject do
    image_files
    get url
  end

  it "ok", skip_propsite: true do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:md5_checksums]).to be_present
  end
end
