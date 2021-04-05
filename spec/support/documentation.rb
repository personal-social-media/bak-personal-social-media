# frozen_string_literal: true

RSpec.configure do |config|
  config.before(documentation: true, valid: true) do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    FactoryBot.rewind_sequences
  end

  config.after(documentation: true, valid: true) do |ex|
    next if ex.exception.present?
    DocumentationService::BuildDocumentation.new(ex).call!
  end
end
