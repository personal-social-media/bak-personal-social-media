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

    private
      def require_current_conversation
        render json: { error: "conversation not found" } if current_conversation.blank?
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(id: params[:conversation_id])
      end
  end
end
