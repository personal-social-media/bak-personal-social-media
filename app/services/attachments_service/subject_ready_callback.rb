# frozen_string_literal: true

module AttachmentsService
  class SubjectReadyCallback
    attr_reader :attached_file
    def initialize(attached_file)
      @attached_file = attached_file
    end

    def call!
      return unless can_trigger?
      subject.attachments_ready!
    end

    private
      def can_trigger?
        all_attached_statuses = AttachedFile.where(subject_id: subject_id).distinct.pluck(:processing_status)
        all_attached_statuses.size == 1 && all_attached_statuses.include?("processed")
      end

      delegate :subject_id, :subject, to: :attached_file
  end
end
