# frozen_string_literal: true

module FriendshipService
  class FriendshipsIndex
    class IndexError < Exception; end
    extend Memoist
    attr_reader :friendships, :start_index, :end_index, :page

    def initialize(params)
      @start_index = params[:start_index]
      @end_index = params[:end_index]
      @page = params[:page]
      @friendships = PeerInfo.accepted
    end

    def call!
      @friendships = paginate
      @friendships = sort
      self
    end

    memoize def friendships_count
      return nil if start_index.present? || end_index.present?
      PeerInfo.accepted.count
    end

    private
      def paginate
        if start_index.blank? && end_index.blank?
          return friendships.page(page).per(10)
        end

        friendships.offset(start_index).limit(limit)
      end

      def sort
        friendships.order(id: :desc)
      end

      memoize def limit
        (end_index.to_i - start_index.to_i).tap do |l|
          raise IndexError, "limit to high" if l > 29
        end
    end
  end
end
