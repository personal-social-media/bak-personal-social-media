# frozen_string_literal: true

module CleaningWorker
  class Uploads < ApplicationWorker
    def perform
      file_system = Shrine.storages[:cache]
      file_system.clear! { |path| path.mtime < Time.now - 1 * 24 * 60 * 60 } # delete files older than 1 day
    end
  end
end
