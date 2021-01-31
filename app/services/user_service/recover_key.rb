# frozen_string_literal: true

module UserService
  class RecoverKey
    def call!
      SecureRandom.hex(30)
    end
  end
end
