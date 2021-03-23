# frozen_string_literal: true

module MessagesService
  class IndexSearch
    class IndexError < Exception; end

    extend Memoist
    attr_reader :conversation_id, :messages, :page, :start_index, :end_index, :count
    def initialize(params)
      @conversation_id = params[:conversation_id]
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
    end

    def call!
      @messages = base_query
      @count = messages.count if page.blank? || page == "1"
      @messages = paginate
      self
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return messages.page(page).per(50)
        end

        messages.offset(start_index).limit(limit)
      end

      def base_query
        Message.order(id: :desc).where(conversation_id: conversation_id)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 99
        end
      end
  end
end
