# frozen_string_literal: true

module PeerInfoWorker
  class Ping < ApplicationWorker
    include WorkersService::RandomScheduled

    def random_delay
      24.hours
    end

    def random_perform
    end
  end
end
