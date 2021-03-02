# frozen_string_literal: true

# internal use
class GalleryElementsController < ApplicationController
  extend Memoist
  before_action :require_current_user
  before_action :require_current_image_album, only: %i(create)

  def index
    @gallery_elements = GalleryElementsService::Index.new(params.permit!).call!
  end

  def destroy
    current_gallery_element.element.destroy
    head :ok
  end

  def create
    @service = GalleryElementsService::Create.new(current_image_album, params.permit![:uploaded_files]).call!
    head :ok
  end

  def all_private_file_names
    names = ImageFile.distinct.pluck(:real_file_name)
    names += VideoFile.distinct.pluck(:real_file_name)

    render json: { names: names.compact }
  end

  def all_md5_checksums
    md5s = ImageFile.distinct.pluck(:md5_checksum)
    md5s += VideoFile.distinct.pluck(:md5_checksum)

    render json: { md5_checksums: md5s.compact }
  end

  private
    def require_current_gallery_element
      render json: { error: "gallery element not found" } if current_gallery_element.blank?
    end

    def current_gallery_element
      @current_gallery_element ||= GalleryElement.find_by(id: params[:id])
    end

    def require_current_image_album
      render json: { error: "image album not found" }, status: 404 if current_image_album.blank?
    end

    memoize def current_image_album
      ImageAlbum.find_by(id: params[:image_album_id])
    end
end
