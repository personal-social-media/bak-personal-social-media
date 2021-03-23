# frozen_string_literal: true

RSpec.configure do |config|
  config.after(documentation: true) do |ex|
    next if ex.exception.present?
    DocumentationService::BuildDocumentation.new(ex).call!
  end
end
