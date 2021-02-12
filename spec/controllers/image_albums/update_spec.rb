# frozen_string_literal: true

require "rails_helper"

describe ImageAlbumsController do
  describe "PATCH :update" do
    let(:image_album) { create(:image_album) }
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
      patch :update, params: { id: image_album.id }.merge(params)
    end

    it "ok" do
      image_album
      expect do
        subject
      end.to change { image_album.reload.name }
        .and change { image_album.description }
        .and change { image_album.location_name }


      expect(response).to have_http_status(:redirect)
    end
  end
end
