# frozen_string_literal: true

module PostService
  class Index
    extend Memoist
    attr_reader :posts, :start_index, :end_index, :page, :base_query

    def initialize(base_query, params)
      @base_query = base_query
      @posts = base_query
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
    end

    def call!
      @posts = paginate
      @posts = add_includes
      @posts = sort
      self
    end

    memoize def posts_count
      return nil if start_index.present? || end_index.present?
      base_query.count
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return posts.page(page).per(10)
        end

        posts.offset(start_index).limit(limit)
      end

      def add_includes
        posts.includes(attached_files: :attachment)
      end

      def sort
        posts.order(id: :desc)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 29
        end
      end
  end
end
