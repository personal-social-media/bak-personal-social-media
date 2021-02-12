# frozen_string_literal: true

class GalleryElementsController < ApplicationController
  extend Memoist
  before_action :require_current_user

  def index
    @gallery_elements = GalleryElementsService::Index.new(params.permit!).call!
  end
end
