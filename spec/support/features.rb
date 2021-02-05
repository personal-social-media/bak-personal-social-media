# frozen_string_literal: true

RUN_FEATURES = ENV["FEATURES"].present?

module FeaturesHelpers
  def screenshot
    page.driver.browser.screenshot(path: Rails.root.join("tmp/screenshot.png"), full: true)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    next unless RUN_FEATURES
    next if ENV["CI"]
    `bin/webpack`
    Timeout.timeout(300) do
      loop until Webpacker.config.public_manifest_path.exist?
    end
  end

  config.around(:each) do |ex|
    type = ex.metadata[:type]

    if RUN_FEATURES && type == :feature
      ex.run
    elsif !RUN_FEATURES && type != :feature
      ex.run
    end
  end

  config.include FeaturesHelpers, type: :feature
end
