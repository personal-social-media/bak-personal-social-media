# frozen_string_literal: true

RSpec.configure do |config|
  config.around :each, :feature do |ex|
    ex.run_with_retry retry: 3
  end
end
