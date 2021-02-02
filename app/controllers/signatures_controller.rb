# frozen_string_literal: true

class SignaturesController < ActionController::Base
  include SessionHelper
  before_action :require_current_user
  before_action :require_permitted_params

  def create
    content = permitted_params[:url] || permitted_params[:text]
    render json: { result: SignaturesService::Sign.new(content).call! }
  end

  def permitted_params
    params.require(:content).permit(:text, :url)
  end

  def require_permitted_params
    head 403 if permitted_params.blank?
  end
end
