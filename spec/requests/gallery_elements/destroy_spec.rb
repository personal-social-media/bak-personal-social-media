# frozen_string_literal: true

require "rails_helper"

describe "DELETE /gallery_elements/:id" do
  let(:gallery_element) { create(:gallery_element) }
  let(:url) { "/gallery_elements/#{gallery_element.id}" }

  before do
    sign_into_controller(GalleryElementsController)
  end

  subject do
    delete url
  end

  it "ok" do
    gallery_element

    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { GalleryElement.count }.by(-1)
      .and change { ImageFile.count }.by(-1)
  end
end
