# frozen_string_literal: true

module AttachmentsService
  class Attach
    def initialize(subject, files)
      @subject = subject
      @files = files
    end

    def call!
    end
  end
end
