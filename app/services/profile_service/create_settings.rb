# frozen_string_literal: true

module ProfileService
  class CreateSettings
    def call!
      return if Setting.count > 1
      Setting.create!
    end
  end
end
