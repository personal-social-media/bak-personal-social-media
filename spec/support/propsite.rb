# frozen_string_literal: true

RSpec.configure do |config|
  config.around(:each) do |ex|
    next ex.run if ex.metadata[:skip_propsite].present?
    Prosopite.scan
    ex.run
    Prosopite.finish
  end
end
