# frozen_string_literal: true

# internal use
class ImageAlbumsController < ApplicationController
  extend Memoist
  before_action :require_current_user
  before_action :require_current_image_album, only: %i(show update destroy)

  def index
    @image_albums_service = ImageAlbumsService::Index.new(params.permit!).call!
    @image_albums = @image_albums_service.image_albums
  end

  def show
    @image_album = current_image_album
    locations_service = ImageAlbumsService::LocationsForImageAlbums.new([current_image_album.id])
    @locations = locations_service.locations_for_image_album(current_image_album)
  end

  def update
    current_image_album.update!(image_albums_params)

    redirect_to image_album_path(current_image_album.id), notice: "Updated"
  rescue ActiveRecord::RecordInvalid => e
    flash[:notice] = e.message
    render :show
  end

  private
    def image_albums_params
      params.require(:image_album).permit(:name, :location_name, :privacy, :description)
    end

    def require_current_image_album
      redirect_to root_path, "Album not found" if current_image_album.blank?
    end

    memoize def current_image_album
      ImageAlbum.find_by(id: params[:id])
    end
end
