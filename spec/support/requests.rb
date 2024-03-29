# frozen_string_literal: true

module RequestsHelper
  def json
    return @json if defined? @json
    begin
      @json = JSON.parse(response.body).deep_symbolize_keys
    rescue Exception
      @json = nil
    end
  end

  def clear_json!
    @json = nil
  end

  def generate_url(url)
    "http://www.example.com#{url}"
  end
end

module SessionsTestHelper
  extend Memoist

  def sign_into_controller(ctrl)
    allow_any_instance_of(ctrl).to receive(:current_user).and_return(current_user)
  end

  memoize def current_user
    create(:profile)
  end
end

module ExternalApiHelpers
  def request_as_verified
    allow_any_instance_of(controller).to receive(:verify_node_request)
  end

  def request_as_server
    allow_any_instance_of(controller).to receive(:require_server)
  end
end

module IdentitiesTestHelper
  def verify_with_private_key(signed, raw)
    private_key.verify(OpenSSL::Digest::SHA256.new, Base32.decode(signed), raw)
  end
end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
  config.include SessionsTestHelper, type: :request
  config.include IdentitiesTestHelper, type: :request
  config.include IdentityService::SignedRequest, type: :request
end
