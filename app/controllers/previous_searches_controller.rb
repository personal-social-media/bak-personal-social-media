# frozen_string_literal: true

class PreviousSearchesController < ActionController::Base
  extend Memoist
  include SessionHelper
  before_action :require_current_user
  before_action :require_current_previous_search, only: %i(destroy)

  def index
    @previous_searches = PreviousSearch.includes(:peer_info).order(updated_at: :desc).page(params[:page]).per(8)
  end

  def create
    create_params = params.require(:peer_info).permit(:id)
    @previous_search = PreviousSearchesService::Create.new(create_params).call!
  end

  def destroy
    current_previous_search.destroy
    head :ok
  end

  private
    memoize def current_previous_search
      PreviousSearch.find_by(id: params[:id])
    end

    def require_current_previous_search
      render json: { error: "previous search not found" }, status: 404 if current_previous_search.blank?
    end
end
