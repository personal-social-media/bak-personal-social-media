# frozen_string_literal: true

# internal use
module Client
  class MessagesController < BaseController
    before_action :require_current_user
    before_action :require_current_conversation, only: :create

    def index
      service = MessagesService::IndexSearch.new(params.permit!).call!
      @messages = service.messages
      @messages_count = service.count
    end

    def create
      @message = MessagesService::CreateClientMessage.new(create_params, current_conversation).call!

    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    private
      def require_current_conversation
        render json: { error: "conversation not found" } if current_conversation.blank?
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(id: params[:conversation_id])
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
