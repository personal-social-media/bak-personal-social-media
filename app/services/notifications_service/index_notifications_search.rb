# frozen_string_literal: true

module NotificationsService
  class IndexNotificationsSearch
    class IndexError < Exception; end
    extend Memoist

    attr_reader :notifications, :page, :start_index, :end_index, :count, :not_seen_count
    def initialize(params)
      @conversation_id = params[:conversation_id]
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
    end

    def call!
      @notifications = base_query
      @count = notifications.count if page.blank? || page == "1"
      @not_seen_count = base_query.where(seen: false).count if page.blank? || page == "1"
      @notifications = paginate
      self
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return notifications.page(page).per(50)
        end

        notifications.offset(start_index).limit(limit)
      end

      def base_query
        Notification.order(id: :desc)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 99
        end
      end
  end
end
