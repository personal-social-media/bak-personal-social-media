# frozen_string_literal: true

unless ENV["FEATURES"]
  require "simplecov"
  SimpleCov.start "rails"

  if ENV["CI"]
    require "codecov"
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  end
end

RSpec.configure do |config|
  config.expose_dsl_globally = true
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  Kernel.srand config.seed
end
