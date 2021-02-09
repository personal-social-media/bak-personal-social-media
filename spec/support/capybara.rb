# frozen_string_literal: true

require "capybara/poltergeist"

Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: true,
    phantomjs_options: %w[--ignore-ssl-errors=yes --ssl-protocol=any],
    timeout: 60,
  }
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.javascript_driver = :poltergeist
