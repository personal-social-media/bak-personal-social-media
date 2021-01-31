# frozen_string_literal: true

class ApplicationWorker
  class << self
    def perform_async(*data)
      new.perform(*data)
    end
  end
end
