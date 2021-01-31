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
end

RSpec.configure do |config|
  config.include RequestsHelper
end
