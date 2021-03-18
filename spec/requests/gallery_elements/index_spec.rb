# frozen_string_literal: true

require "rails_helper"

describe "GET /image_albums/:id/gallery_elements" do
  let(:image_album) { create(:image_album) }
  let(:url) { "/image_albums/#{image_album.id}/gallery_elements" }
  let(:gallery_elements) { create_list(:gallery_element, 2, image_album: image_album) }

  before do
    sign_into_controller(GalleryElementsController)
  end

  subject do
    gallery_elements
    get url
  end

  it "ok", skip_propsite: true do
    subject

    expect(response).to have_http_status(:ok)
    expect(json[:gallery_elements]).to be_present
  end
end
