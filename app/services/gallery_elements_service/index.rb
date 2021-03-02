# frozen_string_literal: true

module GalleryElementsService
  class Index
    attr_reader :image_album_id, :gallery_elements, :page
    def initialize(params)
      @image_album_id = params[:image_album_id]
      @page = params[:page]
    end

    def call!
      @gallery_elements = base_query
      @gallery_elements = paginate
    end

    private
      def paginate
        gallery_elements.page(page).per(200)
      end

      def base_query
        GalleryElement.order(id: :desc).where(image_album_id: image_album_id).includes(:element)
      end
  end
end
