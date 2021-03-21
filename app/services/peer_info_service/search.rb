# frozen_string_literal: true

module PeerInfoService
  class Search
    attr_reader :ids, :query, :name_like, :page, :limit, :public_keys, :friend_ship_status

    def initialize(query: PeerInfo, page: 1, limit:, ids: nil, public_keys: nil, name_like: nil, friend_ship_status: nil)
      @query = query
      @ids = ids
      @page = page
      @name_like = name_like
      @public_keys = public_keys
      @limit = limit
      @friend_ship_status = friend_ship_status
    end

    def call!
      @query = apply_search_by_ids
      @query = apply_name_like
      @query = apply_search_friend_ship_status
      @query = apply_public_keys
      @query = apply_pagination if ids.blank? && public_keys.blank?

      query
    end

    private
      def apply_pagination
        query.page(page).per(limit)
      end

      def apply_search_by_ids
        return query if ids.blank?
        query.where(id: ids.split(","))
      end

      def apply_search_friend_ship_status
        return query if friend_ship_status.blank?
        query.where(friend_ship_status: friend_ship_status)
      end

      def apply_name_like
        return query if name_like.blank?
        query.name_similar(name_like)
      end

      def apply_public_keys
        return query if public_keys.blank?
        query.where(public_key: public_keys)
      end
  end
end
