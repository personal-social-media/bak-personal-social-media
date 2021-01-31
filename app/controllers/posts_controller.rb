# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_current_user

  def create
    p params
    head :ok
  end

  def create_permitted_params
    params.require(:post).permit(:content, files: [])
  end
end
