# frozen_string_literal: true

# == Schema Information
#
# Table name: attached_files
#
#  id              :bigint           not null, primary key
#  attachment_type :string           not null
#  subject_type    :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachment_id   :bigint           not null
#  subject_id      :bigint           not null
#
# Indexes
#
#  index_attached_files_on_attachment  (attachment_type,attachment_id)
#  index_attached_files_on_subject     (subject_type,subject_id)
#
class AttachedFile < ApplicationRecord
  belongs_to :attachment, polymorphic: true
  belongs_to :subject, polymorphic: true

  def image?
    attachment_type == "ImageFile"
  end
end
