# frozen_string_literal: true

# internal use
module Client
  class MessagesController < BaseController
    before_action :require_current_user
    before_action :require_current_conversation, only: :create
    before_action :require_current_message, only: :update

    def index
      service = MessagesService::IndexSearch.new(params.permit!).call!
      @messages = service.messages
      @messages_count = service.count

    rescue MessagesService::IndexSearch::IndexError => e
      render json: { error: e.message }, status: 422
    end

    def create
      @message = MessagesService::CreateClientMessage.new(create_params, current_conversation).call!

    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def update
      MessagesService::UpdateClientMessage.new(current_message, update_params).call!
      @message = current_message
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    private
      def require_current_conversation
        render json: { error: "conversation not found" } if current_conversation.blank?
      end

      def current_message
        @current_message ||= Message.find_by(id: params[:id], message_owner: :peer)
      end

      def require_current_message
        render json: { error: "message not found" } if current_message.blank?
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(id: params[:conversation_id])
      end

      def update_params
        params.require(:message).permit(:read)
      end

      def create_params
        params.require(:message).permit(:message_type, payload: payload_params, uploaded_files: %w[.path .md5 .name])
      end

      def payload_params
        [
          :message
        ]
      end
  end
end
