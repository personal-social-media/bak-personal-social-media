# frozen_string_literal: true

class ImageAlbumsController < ApplicationController
  before_action :require_current_user

  def index
    @image_albums_service = ImageAlbumsService::Index.new(params.permit!).call!
    @image_albums = @image_albums_service.image_albums
  end
end
