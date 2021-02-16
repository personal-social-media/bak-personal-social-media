# frozen_string_literal: true

module WorkersService
  module RandomScheduled
    def perform(run_now = false)
      return self.class.perform_in(calculate_random_delay, true) unless run_now
      random_perform
    end

    def random_delay
      raise "please define #random_delay"
    end

    def random_perform
      raise "please define #random_perform"
    end

    def calculate_random_delay
      rand(1..random_delay).seconds
    end
  end
end
