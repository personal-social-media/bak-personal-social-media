# frozen_string_literal: true

module CommentsService
  class CommentsIndex
    class IndexError < Exception; end
    extend Memoist
    attr_reader :comments, :subject, :start_index, :end_index, :page, :parent_comment_id

    def initialize(subject, params)
      @subject = subject
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
      @parent_comment_id = params[:parent_comment_id]
      @comments = parent_comment_id.present? ? subject.comments.where(parent_comment_id: parent_comment_id) : subject.comments
    end

    def call!
      @comments = paginate
      @comments = add_includes
      @comments = sort
      self
    end

    memoize def comments_count
      return nil if start_index.present? || end_index.present?
      subject.comments.count
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return comments.page(page).per(10)
        end

        comments.offset(start_index).limit(limit)
      end

      def add_includes
        comments.includes(:peer_info)
      end

      def sort
        comments.order(id: :desc)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 29
        end
      end
  end
end
