# frozen_string_literal: true

module ReactionsService
  class ReactionsIndex
    class IndexError < Exception; end
    extend Memoist
    attr_reader :reactions, :subject, :start_index, :end_index, :page

    def initialize(subject, params)
      @subject = subject
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
      @reactions = subject.reactions
    end

    def call!
      @reactions = paginate
      @reactions = add_includes
      @reactions = sort
      self
    end

    memoize def reactions_count
      return nil if start_index.present? || end_index.present?
      subject.reactions.count
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return reactions.page(page).per(10)
        end

        reactions.offset(start_index).limit(limit)
      end

      def add_includes
        reactions.includes(:peer_info)
      end

      def sort
        reactions.order(id: :desc)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 29
        end
      end
  end
end
