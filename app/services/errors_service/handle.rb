# frozen_string_literal: true

module ErrorsService
  class Handle
    attr_reader :error, :handled_classes

    def initialize(error, handled_classes: [])
      @error = error
      @handled_classes = handled_classes
    end

    def call!
      raise error unless is_handled?
    end

    private
      def is_handled?
        handled_classes.include?(error.class)
      end
  end
end
