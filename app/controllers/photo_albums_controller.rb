# frozen_string_literal: true

class ImageAlbumsControllers < ApplicationController
  before_action :require_current_user

  def index
    service = ImageAlbumsService::Index.new(params.permit!)
    @image_albums = service.image_albums
    @preview_images = service.preview_images
  end
end
