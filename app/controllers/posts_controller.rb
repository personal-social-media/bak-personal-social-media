# frozen_string_literal: true

# internal use
class PostsController < ApplicationController
  before_action :require_current_user

  def create
    Post.transaction do
      @post = Post.create!(post_params.except(:uploaded_files))
      time = Time.zone.now
      album_title = "Posts #{time.strftime("%B %Y")}"
      uploaded_files_params = post_params[:uploaded_files]

      if uploaded_files_params
        uploaded_files = UploadsService::HandleMultipleUpload.new(uploaded_files_params).call!
        AttachmentsService::Attach.new(@post, uploaded_files, album_title, false).call!
      else
        @post.sync_create
      end
    end

    head :ok
  end

  def post_params
    params.require(:post).permit!.slice(:content, :uploaded_files)
  end
end
