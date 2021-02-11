# frozen_string_literal: true

module ImageAlbumsService
  class Index
    extend Memoist
    attr_reader :params, :image_albums

    def initialize(params)
      @params = params
    end

    def call!
      @image_albums = base_query
      @image_albums = apply_pagination
      convert_to_list
    end

    private
      def apply_pagination
        image_albums.page(params[:page]).per(20)
      end

      memoize def base_query
        search.present? ? PgSearch.multisearch(search).includes(:searchable) : ImageAlbum
      end

      def convert_to_list
        return image_albums if base_query == ImageAlbum
        image_albums.map(&:searchable)
      end

      memoize def search
        params[:q]
      end

      def preview_images
      end
  end
end
