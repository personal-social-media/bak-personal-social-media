# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_current_user

  def create
    @post = Post.create!(post_params)
    time = Time.zone.now
    album_title = "Posts #{time.strftime("%B %Y")}"
    AttachmentsService::Attach.new(@post, files_params[:files], album_title).call!

    head :ok
  end

  def files_params
    params.require(:post).permit(files: [])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
