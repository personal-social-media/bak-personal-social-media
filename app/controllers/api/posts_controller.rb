# frozen_string_literal: true

module Api
  class PostsController < BaseController
    include UploadsHelper
    extend Memoist
    before_action :verify_node_request
    before_action :verify_not_blocked
    before_action :require_friend, except: %i(index show)

    def index
      @posts = base_query.includes(attached_files: :attachment).page(params[:page]).per(20)
    end

    def show
      @post = current_post(attached_files: :attachment)
      return unless require_current_post(post)
    end

    private
      def base_query
        Post
      end

      memoize def current_post(**includes)
        return base_query.find_by(uid: params[:id]) if includes.blank?

        base_query.includes(**includes).find_by(uid: params[:id])
      end

      def require_current_post(post)
        render json: { error: "post not found" }, status: 404 if post.blank?
        post.present?
      end
  end
end
