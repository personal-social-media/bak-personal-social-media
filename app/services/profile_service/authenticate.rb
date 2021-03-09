# frozen_string_literal: true

module ProfileService
  class Authenticate
    extend Memoist
    attr_reader :recovery_key
    def initialize(recovery_key)
      @recovery_key = recovery_key
    end

    def call!
      return nil unless profile&.authenticate_recovery_key(recovery_key)
      profile
    end

    memoize def profile
      Profile.first
    end
  end
end
