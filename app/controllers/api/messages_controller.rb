# frozen_string_literal: true

# external use
module Api
  class MessagesController < BaseController
    before_action :require_server
    before_action :verify_node_request
    before_action :require_current_peer_info
    before_action :verify_not_blocked
    before_action :require_current_conversation
    before_action :require_current_message, only: :update

    def create
      @message = MessagesService::CreateMessage.new(current_conversation, create_params).call!
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def update
      current_message.update!(update_params)
      @message = current_message
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    private
      def create_params
        params.require(:message).permit(:message_type, :signature, :remote_id, payload: payload)
      end

      def update_params
        params.require(:message).permit(:read)
      end

      def payload
        [
          :message,
          images: [
            :type,
            :desktop,
            :mobile,
            :thumbnail
          ],
          videos: [
            :type,
            :original,
            :short,
            :original_screenshot,
            :thumbnail_screenshot,
          ]
        ]
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(peer_info: current_peer_info)
      end

      def require_current_conversation
        render json: { error: "conversation not found" }, status: 404 if current_conversation.blank?
      end

      def current_message
        @current_message ||= current_conversation.messages.find_by(id: params[:id], message_owner: :self)
      end

      def require_current_message
        render json: { error: "message not found" }, status: 404 if current_message.blank?
      end
  end
end
