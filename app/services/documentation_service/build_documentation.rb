# frozen_string_literal: true

module DocumentationService
  class BuildDocumentation
    attr_reader :spec_ctx
    def initialize(spec_ctx)
      @spec_ctx = spec_ctx
    end

    def call!
      ValidateDocumentation.new(spec_ctx).call!
      DocumentationRecord.new(spec_ctx).save!
    end
  end
end
