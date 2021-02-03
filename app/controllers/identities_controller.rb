# frozen_string_literal: true

class IdentitiesController < ActionController::Base
  include NodeVerifyRequest
  before_action :verify_node_request

  def create
    public_key = Base32.decode(request.headers["Public-Key"])
    @identity = PeerInfo.find_or_initialize_by(public_key: public_key).tap do |id|
      permitted_params = params.require(:identity).permit(:username, :name, :about, :city_name, :country_code, avatars: {})
      unless id.persisted?
        id.username = permitted_params[:username]
      end
      id.name = permitted_params[:name]
      id.avatars = permitted_params[:avatars]
      id.about = permitted_params[:about]
      id.city_name = permitted_params[:city_name]
      id.country_code = permitted_params[:country_code]
      id.ip = request.headers["Gateway"]
      id.save!
    end
  end
end
