# frozen_string_literal: true

# internal use
class GalleryElementsController < ApplicationController
  extend Memoist
  before_action :require_current_user

  def index
    @gallery_elements = GalleryElementsService::Index.new(params.permit!).call!
  end

  def all_private_file_names
    names = ImageFile.where(private: true).distinct.pluck(:real_file_name)

    render json: { names: names }
  end

  def all_md5_checksums
    md5s = ImageFile.where.not(md5_checksum: nil).distinct.pluck(:real_file_name)

    render json: { md5_checksums: md5s }
  end
end
