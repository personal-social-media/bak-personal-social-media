# frozen_string_literal: true

class StaticController < ActionController::Base
  include NodeVerifyRequest
  include SessionHelper
  before_action :verify_node_request, only: :public_key
  # before_action :require_current_user, only: :authorize_upload

  def public_key
    path = Rails.application.secrets.dig(:profile, :keys_location) + "/public_key.pem"
    return head 404 unless File.exist?(path)

    http_cache_forever(public: true) do
      send_file(path, type: "text/plain", filename: "public_key.pem")
    end
  end

  def authorize_upload
    head :ok
  end

  def ignore_register
    true
  end
end
