# frozen_string_literal: true

class ImageAlbumsController < ApplicationController
  before_action :require_current_user

  def index
    service = ImageAlbumsService::Index.new(params.permit!)
    @image_albums = service.image_albums
  end
end
