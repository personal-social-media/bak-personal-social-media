# frozen_string_literal: true

# internal use
class VerificationResultsController < ApplicationController
  extend Memoist
  before_action :require_current_user
  before_action :require_done_current_verification_result, only: :update
  before_action :require_current_verification_result, only: :show

  def index
    @verification_results = VerificationResultsService::IndexSearch.new(params.permit![:search]).call!
  end

  def create
    @verification_result = VerificationResultsService::CreateVerificationResult.new(permitted_params).call!

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: 422
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: 422
  end

  def show
    @verification_result = current_verification_result
  end

  def update
    done_current_verification_result.run_verification!
    @verification_result = done_current_verification_result

    head :ok
  end

  private
    def permitted_params
      params.require(:verification_result).permit(:remote_type, :remote_id, :peer_info_id)
    end

    memoize def done_current_verification_result
      VerificationResult.where(status: :done).find_by(id: params[:id])
   end

    def require_done_current_verification_result
      render json: { error: "verification result not found" }, status: 404 if done_current_verification_result.blank?
    end

    memoize def current_verification_result
      VerificationResult.find_by(id: params[:id])
    end

    def require_current_verification_result
      render json: { error: "verification result not found" }, status: 404 if current_verification_result.blank?
    end
end
