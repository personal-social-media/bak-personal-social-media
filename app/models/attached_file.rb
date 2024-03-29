# frozen_string_literal: true

# == Schema Information
#
# Table name: attached_files
#
#  id                :bigint           not null, primary key
#  attachment_type   :string           not null
#  processing_status :string           default("processing")
#  subject_type      :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  attachment_id     :bigint           not null
#  subject_id        :bigint           not null
#
# Indexes
#
#  index_attached_files_on_attachment  (attachment_type,attachment_id)
#  index_attached_files_on_subject     (subject_type,subject_id)
#
class AttachedFile < ApplicationRecord
  belongs_to :attachment, polymorphic: true
  belongs_to :subject, polymorphic: true
  str_enum :processing_status, %i(processing failed processed)
  after_commit :trigger_subject_callback, on: :update, if: -> { previous_changes["processing_status"].present? && processed? }
  after_commit :trigger_subject_callback, on: :create, if: -> { processed? }

  def image?
    attachment_type == "ImageFile"
  end

  def video?
    attachment_type == "VideoFile"
  end

  def trigger_subject_callback
    AttachmentsService::SubjectReadyCallback.new(self).call!
  end
end
