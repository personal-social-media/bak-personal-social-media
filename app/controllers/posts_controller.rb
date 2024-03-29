# frozen_string_literal: true

# internal use
class PostsController < ApplicationController
  before_action :require_current_user
  before_action :require_current_post, only: :destroy

  def create
    Post.transaction do
      @post = Post.create!(post_params.except(:uploaded_files))
      time = Time.zone.now
      album_title = "Posts #{time.strftime("%B %Y")}"
      uploaded_files_params = post_params[:uploaded_files]

      if uploaded_files_params.present?
        uploaded_files = UploadsService::HandleMultipleUpload.new(uploaded_files_params).call!
        elements_options = { is_private: false }
        album_options = { album_name: album_title, album_manual_upload: false }
        AttachmentsService::Attach.new(@post, uploaded_files, elements_options: elements_options, album_options: album_options).call!
      else
        @post.sync_create
      end
    end

    head :ok
  end

  def destroy
    current_post.destroy
    head :ok
  end

  private
    def current_post
      @current_post ||= Post.find_by(id: params[:id])
    end

    def require_current_post
      render_not_found if current_post.blank?
    end

    def post_params
      params.require(:post).permit!.slice(:content, :uploaded_files)
    end
end
