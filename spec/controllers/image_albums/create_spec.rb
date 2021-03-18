# frozen_string_literal: true

require "rails_helper"

describe ImageAlbumsController do
  describe "POST :create" do
    let(:image_album) { build(:image_album) }
    let(:params) do
      {
        image_album: {
          name: "new name",
          location_name: "new name",
          privacy: "public_access",
          description: "new description",
        }
      }
    end

    subject do
      login
      post :create, params: params
    end

    it "ok" do
      expect do
        subject
      end.to change { ImageAlbum.count }.by(1)

      expect(response).to have_http_status(:redirect)
    end
  end
end
