# frozen_string_literal: true

class Setup::ChecksBeforeRegisterComponent < ViewComponent::Base
  extend Memoist
  attr_reader :f
  def initialize(f:)
    @f = f
  end

  memoize def checks
    SetupService::Checks.new
  end

  delegate :error, to: :checks
end
