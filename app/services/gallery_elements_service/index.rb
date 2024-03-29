# frozen_string_literal: true

module GalleryElementsService
  class Index
    class IndexError < Exception; end

    extend Memoist
    attr_reader :image_album_id, :gallery_elements, :page, :start_index, :end_index
    def initialize(params)
      @image_album_id = params[:image_album_id]
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
    end

    def call!
      @gallery_elements = base_query
      @gallery_elements = paginate
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return gallery_elements.page(page).per(50)
        end

        gallery_elements.offset(start_index).limit(limit)
      end

      def base_query
        GalleryElement.order(id: :desc).where(image_album_id: image_album_id).includes(:element)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 99
        end
      end
  end
end
