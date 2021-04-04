# frozen_string_literal: true

# internal use
module Client
  class ConversationsController < BaseController
    before_action :require_current_user
    before_action :require_current_conversation, only: %i(update)
    before_action :require_current_conversation_show, only: %i(show)

    def index
      service = ConversationsService::ConversationsIndex.new(params.permit!).call!
      @conversations = service.query
      @count = service.count
    end

    def show
      @conversation = current_conversation_show
    end

    def create
      create_params = params.require(:conversation).permit(:peer_info_id)
      @conversation = ConversationsService::ConversationsCreate.new(create_params).call!

    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound, ConversationsService::ConversationsCreate::Error => e
      render json: { error: e.message }, status: 422
    end

    def update
      update_params = params.require(:conversation).permit(:is_typing)
      ConversationsService::ConversationsUpdate.new(current_conversation, update_params).call!

      @conversation = current_conversation
    end

    private
      def require_current_conversation
        render json: { error: "conversation not found" }, status: 404 if current_conversation.blank?
      end

      def current_conversation
        @current_conversation ||= Conversation.find_by(id: params[:id])
      end

      def require_current_conversation_show
        render json: { error: "conversation not found" }, status: 404 if current_conversation_show.blank?
      end

      def current_conversation_show
        @current_conversation_show ||= Conversation.find_by(peer_info_id: params[:id])
      end
  end
end
