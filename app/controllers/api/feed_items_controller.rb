# frozen_string_literal: true

# external use
module Api
  class FeedItemsController < BaseController
    include UploadsHelper
    extend Memoist
    before_action :require_server
    before_action :verify_node_request
    before_action :require_current_peer_info
    before_action :verify_not_blocked
    before_action :require_friend
    before_action :require_current_feed_item, only: :destroy

    def create
      FeedItem.find_or_initialize_by(peer_info: current_peer_info, uid: feed_item_params[:uid]).tap do |f|
        next if f.persisted?
        f.url = feed_item_params[:url]
        f.feed_item_type = feed_item_params[:feed_item_type]
        f.save!
      end

      head :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def destroy
      current_feed_item.destroy
      head :ok
    end

    private
      memoize def feed_item_params
        params.require(:feed_item).permit(:feed_item_type, :uid, :url)
      end

      def require_current_feed_item
        render json: { error: "feed item not found" }, status: 404 if current_feed_item.blank?
      end

      def current_feed_item
        FeedItem.find_by(peer_info: current_peer_info, uid: params[:id])
      end
  end
end
