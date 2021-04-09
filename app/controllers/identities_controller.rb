# frozen_string_literal: true

# external use
class IdentitiesController < ActionController::Base
  include NodeVerifyRequest
  before_action :verify_node_request
  before_action :require_current_peer_info, only: :ping
  before_action :verify_not_blocked, only: :ping
  skip_before_action :verify_authenticity_token, only: :ping

  def create
    public_key = Base32.decode(request.headers["Public-Key"])
    @identity = PeerInfo.find_or_initialize_by(public_key: public_key).tap do |id|
      permitted_params = params.require(:identity).permit(:username, :name, :about, :city_name, :country_code, :signature, avatars: [
        :type, :original, :short, :original_screenshot, :thumbnail_screenshot, :desktop, :mobile, :thumbnail
      ])
      if !id.persisted? || id.username == "UNKNOWN"
        id.username = permitted_params[:username]
      end
      id.name = permitted_params[:name]
      id.avatars = permitted_params[:avatars]
      id.about = permitted_params[:about]
      id.city_name = permitted_params[:city_name]
      id.country_code = permitted_params[:country_code]
      id.ip = request.headers["Gateway"]
      id.signature = permitted_params[:signature]
      id.save!
    end
    head :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: 422
end

  def ping
    current_peer_info.update(server_last_seen: Time.zone.now)
    head :ok
  end
end
