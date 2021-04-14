# frozen_string_literal: true

return unless Rails.env.production?
return unless ENV["BUGSNAG"]

Bugsnag.configure do |config|
  config.api_key = ENV["BUGSNAG"]
end
