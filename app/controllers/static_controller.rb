# frozen_string_literal: true

# mix use
class StaticController < ActionController::Base
  include NodeVerifyRequest
  include SessionHelper
  before_action :verify_node_request, only: :public_key
  before_action :require_current_user, only: %i(authorize_upload not_found)

  # external use
  def public_key
    path = Rails.application.secrets.dig(:profile, :keys_location) + "/public_key.pem"
    return head 404 unless File.exist?(path)

    http_cache_forever(public: true) do
      send_file(path, type: "text/plain", filename: "public_key.pem")
    end
  end

  # internal use
  def authorize_upload
    head :ok
  end

  # mix use
  def not_found
    @title = "Page not found"
    render(layout: "layouts/application")
  end

  private
    def ignore_register
      true
    end
end
