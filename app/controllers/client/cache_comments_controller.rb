# frozen_string_literal: true

# internal use
module Client
  class CacheCommentsController < BaseController
    before_action :require_current_user
    before_action :require_current_cache_comment, only: %i(update destroy)

    def create
      CacheCommentsService::CreateCacheComment.new(create_params).call!

      head :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    rescue ActiveRecord::RecordNotFound
      render json: { error: "subject not found" }, status: 404
    end

    def update
      CacheCommentsService::UpdateCacheComment.new(update_params, current_cache_comment).call!

      head :ok
    rescue ActiveRecord::RecordInvalid, CacheCommentsService::UpdateCacheComment::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end

    def destroy
      CacheCommentsService::DestroyCacheComment.new(current_cache_comment).call!

      head :ok
    rescue CacheCommentsService::DestroyCacheComment::Error, TimeoutError => e
      render json: { error: e.message }, status: 422
    end

    private
      def create_params
        params.require(:cache_comment).permit(:subject_id, :subject_type, :peer_info_id,
                                              :payload_subject_id, :payload_subject_type, :parent_comment_id,
                                              payload: [:message], uploaded_files: %w[.path .md5 .name])
      end

      def update_params
        params.require(:cache_comment).permit(:like_count, :love_count, :wow_count, payload: payload_params, uploaded_files: %w[.path .md5 .name])
      end

      def current_cache_comment
        @current_cache_comment ||= CacheComment.find_by(id: params[:id])
      end

      def require_current_cache_comment
        render json: { error: "cache comment not found" }, status: 404 if current_cache_comment.blank?
      end
  end
end
