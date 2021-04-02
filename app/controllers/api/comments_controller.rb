# frozen_string_literal: true

# external use
module Api
  class CommentsController < BaseController
    extend Memoist
    before_action :require_server, only: %i(create update destroy)
    before_action :verify_node_request
    before_action :require_friend, only: %i(create show update destroy)
    before_action :verify_not_blocked
    before_action :require_current_subject, only: :create
    before_action :require_index_current_subject, only: :index
    before_action :require_current_comment, only: %i(show update destroy)

    def index
      service = CommentsService::CommentsIndex.new(index_current_subject, params.permit!).call!
      @comments = service.comments
      @comments_count = service.comments_count

    rescue CommentsService::CommentsIndex::IndexError => e
      render json: { error: e.message }, status: 422
    end

    def create
      @comment = CommentsService::CreateComment.new(current_peer_info, current_subject, permitted_params[:payload], permitted_params[:signature]).call!
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: 404
    end

    def show
      @comment = current_comment
    end

    def update
      current_comment.update!(permitted_params_update)
      @comment = current_comment
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def destroy
      current_comment.destroy
      head :ok
    end

    private
      def require_current_subject
        render json: { error: "subject not found" }, status: 404 if current_subject.blank?
      end

      def require_index_current_subject
        render json: { error: "subject not found" }, status: 404 if index_current_subject.blank?
      end

      def require_current_comment
        render json: { error: "comment not found" }, status: 404 if current_comment.blank?
      end

      memoize def current_comment
        Comment.where(peer_info: current_peer_info).find_by(id: params[:id])
      end

      memoize def current_subject
        CommentsService::CurrentSubject.new(permitted_params).call!
      end

      memoize def index_current_subject
        permitted_params = params.permit!.slice(:subject_type, :subject_id)
        CommentsService::CurrentSubject.new(permitted_params).call!
      end

      memoize def permitted_params
        params.require(:comment).permit(:subject_id, :subject_type, :signature, payload: payload_params)
      end

      def payload_params
        [
          :message, :subject_id, :subject_type, :parent_comment_id,
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

      def permitted_params_update
        params.require(:comment).permit(:signature, payload: payload_params)
      end
  end
end
