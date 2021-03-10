# frozen_string_literal: true

# external use
module Api
  class PostsController < BaseController
    include UploadsHelper
    extend Memoist
    before_action :verify_node_request
    before_action :verify_not_blocked
    before_action :require_friend, except: %i(index show)

    def index
      service = PostService::Index.new(base_query, params.permit!).call!
      @posts = service.posts
      @posts_count = service.posts_count
    end

    def show
      @post = current_post(attached_files: :attachment)
      require_current_post(post)
    end

    private
      def base_query
        @base_query ||= PrivacyService::PrivacyBaseQuery.new(Post, is_friend?).call!
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
