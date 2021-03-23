# frozen_string_literal: true

module ConversationsService
  class ConversationsIndex
    extend Memoist
    attr_reader :params, :query, :count, :start_index, :end_index, :page, :peer_name
    def initialize(params)
      @params = params
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
      @peer_name = params[:peer_name]
      @query = Conversation
    end

    def call!
      @query = apply_search_by_peer_name if peer_name.present?
      @count = @query.count if page.blank? || page == "1"
      @query = apply_pagination
      self
    end

    def apply_search_by_peer_name
      query.joins(:peer_info).merge(PeerInfo.name_similar(peer_name))
    end

    def apply_pagination
      if start_index.blank? && end_index.blank?
        return query.page(page).per(50)
      end

      query.offset(start_index).limit(limit)
    end

    memoize def limit
      (end_index.to_i - start_index.to_i).tap do |l|
        raise IndexError, "limit to high" if l > 50
      end
    end
  end
end
