# frozen_string_literal: true

require "rails_helper"

describe ImageAlbumsController do
  describe "GET :index" do
    let(:gallery_elements) { create_list(:gallery_element, 3) }

    subject do
      gallery_elements
      login
      get :index
    end

    it "ok", skip_propsite: true do
      subject

      expect(response).to have_http_status(:ok)
    end
  end
end
