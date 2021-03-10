# frozen_string_literal: true

# external use
module Api
  class ReactionsController < BaseController
    extend Memoist
    before_action :require_server
    before_action :verify_node_request
    before_action :require_friend
    before_action :verify_not_blocked
    before_action :require_current_subject, only: :create
    before_action :require_current_reaction, only: :destroy

    def create
      @reaction = ReactionsService::CreateReaction.new(current_peer_info, current_subject, permitted_params[:reaction_type]).call!
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def update
      current_reaction.update!(permitted_params_update)
      @reaction = current_reaction
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def destroy
      current_reaction.destroy
      head :ok
    end

    private
      def require_current_subject
        render json: { error: "subject not found" }, status: 404 if current_subject.blank?
      end

      def require_current_reaction
        render json: { error: "reaction not found" }, status: 404 if current_reaction.blank?
      end

      memoize def current_reaction
        Reaction.where(peer_info: current_peer_info).find_by(id: params[:id])
      end

      memoize def current_subject
        ReactionsService::CurrentSubject.new(permitted_params).call!
      end

      memoize def permitted_params
        params.require(:reaction).permit(:subject_id, :subject_type, :reaction_type)
      end

      def permitted_params_update
        params.require(:reaction).permit(:reaction_type)
      end
  end
end
