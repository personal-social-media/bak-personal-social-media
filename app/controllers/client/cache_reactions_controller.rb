# frozen_string_literal: true

# internal use
module Client
  class CacheReactionsController < BaseController
    before_action :require_current_user
    before_action :require_current_cache_reaction, only: %i(update destroy)

    def index
      @cache_reactions = CacheReactionsService::Index.new(params.permit![:search]).call!
    end

    def create
      CacheReactionsService::CreateCacheReaction.new(create_params).call!

      head :ok
    rescue ActiveRecord::RecordInvalid, CacheReactionsService::CreateCacheReaction::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    rescue ActiveRecord::RecordNotFound
      render json: { error: "subject not found" }, status: 404
    end

    def update
      CacheReactionsService::UpdateCacheReaction.new(update_params, current_cache_reaction).call!

      head :ok
    rescue ActiveRecord::RecordInvalid, CacheReactionsService::UpdateCacheReaction::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end


    def destroy
      CacheReactionsService::DestroyCacheReaction.new(current_cache_reaction).call!

      head :ok
    rescue CacheReactionsService::DestroyCacheReaction::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end

    private
      def create_params
        params.require(:cache_reaction).permit(:subject_id, :subject_type, :reaction_type)
      end

      def update_params
        params.require(:cache_reaction).permit(:reaction_type)
      end

      def current_cache_reaction
        @current_cache_reaction ||= CacheReaction.find_by(id: params[:id])
      end

      def require_current_cache_reaction
        render json: { error: "cache reaction not found" }, status: 404 if current_cache_reaction.blank?
      end
  end
end
