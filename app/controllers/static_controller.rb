# frozen_string_literal: true

class StaticController < ActionController::Base
  include NodeVerifyRequest
  before_action :verify_node_request

  def public_key
    path = Rails.application.secrets.dig(:profile, :keys_location) + "/public_key.pem"
    return head 404 unless File.exist?(path)

    http_cache_forever(public: true) do
      send_file(path, type: "text/plain", filename: "public_key.pem")
    end
  end

  def ignore_register
    true
  end
end
