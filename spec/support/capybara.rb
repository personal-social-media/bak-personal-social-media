# frozen_string_literal: true

require "capybara/cuprite"
Capybara.javascript_driver = :cuprite
Capybara.default_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800], browser_options: { 'no-sandbox': nil })
end

Capybara.default_max_wait_time = 30
