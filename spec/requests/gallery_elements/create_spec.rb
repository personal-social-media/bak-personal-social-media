# frozen_string_literal: true

require "rails_helper"

describe "/image_albums/:image_album_id/gallery_elements/upload" do
  include FilesSpecHelper
  let(:image_album) { create(:image_album) }
  let(:url) { "/image_albums/#{image_album.id}/gallery_elements/upload" }
  let(:params) do
    {
      uploaded_files: [
        {
          ".name": "a.png",
          ".path": sample_image_tmp,
          ".md5": "md5"
        }
      ]
    }
  end

  before do
    sign_into_controller(GalleryElementsController)
  end

  subject do
    post url, params: params
  end

  it "POST /image_albums/:image_album_id/gallery_elements/upload" do
    expect do
      subject
      expect(response).to have_http_status(:ok)
    end.to change { ImageFile.count }.by(1)
  end
end
