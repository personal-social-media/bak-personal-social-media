# frozen_string_literal: true

# external use
module Api
  class ConversationsController < BaseController
    before_action :require_server
    before_action :verify_node_request
    before_action :require_current_peer_info
    before_action :verify_not_blocked
    before_action :require_current_conversation, only: %i(update)

    def create
      @conversation = Conversation.find_or_create_by!(peer_info: current_peer_info)
    end

    def update
      current_conversation.update!(update_params)
      @conversation = current_conversation
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    private
      def update_params
        params.require(:conversation).permit(:is_typing)
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(peer_info: current_peer_info)
      end

      def require_current_conversation
        render json: { error: "conversation not found" }, status: 404 if current_conversation.blank?
      end
  end
end
