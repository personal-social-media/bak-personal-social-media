# frozen_string_literal: true

RSpec.configure do |config|
  config.around :each, :feature do |ex|
    ex.run_with_retry retry: 3
  end

  config.retry_callback = proc do |ex|
    if ex.metadata[:type] == :feature
      Capybara.reset!
    end
  end
end
