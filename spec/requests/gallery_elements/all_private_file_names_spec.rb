# frozen_string_literal: true

require "rails_helper"

describe "GET /gallery_elements/all_private_file_names" do
  let(:url) { "/gallery_elements/all_private_file_names" }
  let(:image_files) { create_list(:image_file, 2, private: true, real_file_name: "a.png") }

  before do
    sign_into_controller(GalleryElementsController)
  end

  subject do
    image_files
    get url
  end

  it "ok" do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:names]).to be_present
  end
end
