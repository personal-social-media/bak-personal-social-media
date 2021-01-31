# frozen_string_literal: true

module PageService
  class Title
    attr_reader :current

    def initialize(current)
      @current = current
    end

    def call!
      [@current, default].compact.join(" - ")
    end

    def default
      "Personal Social Media"
    end
  end
end
