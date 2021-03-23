# frozen_string_literal: true

RSpec.configure do |config|
  config.before(documentation: true) do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  config.after(documentation: true) do |ex|
    next if ex.exception.present?
    DocumentationService::BuildDocumentation.new(ex).call!
  end
end
