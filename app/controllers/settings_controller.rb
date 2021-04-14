# frozen_string_literal: true

# internal use
class SettingsController < ApplicationController
  include SessionHelper
  before_action :require_current_user

  def update
    settings.update!(permitted_params)

    render json: { setting: settings }
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: 422
  end

  def permitted_params
    params.require(:setting).permit(:ui_sidebar_opened)
  end
end
