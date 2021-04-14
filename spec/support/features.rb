# frozen_string_literal: true

RUN_FEATURES = ENV["FEATURES"].present?

module FeaturesHelpers
  extend Memoist
  def screenshot
    page.driver.save_screenshot Rails.root.join("tmp/screenshot.png"), format: :png
    raise "screenshot"
  end

  def sign_in
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end

  def click_invisible
    Capybara.ignore_hidden_elements = false
    yield
    Capybara.ignore_hidden_elements = true
  end

  memoize def current_user
    create(:profile)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    next unless RUN_FEATURES
    next if ENV["CI"]
    next if Dir.exist?(Rails.root.join("public/packs")) && ENV["COMPILE"].blank?
    `bundle exec rake assets:precompile`
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

  config.before(:each, type: :feature) do
    next unless RUN_FEATURES
    create(:setting)
  end

  config.include FeaturesHelpers, type: :feature
end
