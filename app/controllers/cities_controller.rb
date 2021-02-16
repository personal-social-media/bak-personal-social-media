# frozen_string_literal: true

# internal use
class CitiesController < ActionController::Base
  include SessionHelper
  before_action :require_current_user
  before_action :require_current_country

  def index
    render json: { cities: current_country.cities.keys.map(&:titleize) }
  end

  def current_country
    @current_country ||= ISO3166::Country[params[:q]]
  end

  def require_current_country
    render json: { error: "country not found" }, status: 404 if current_country.blank?
  end
end
