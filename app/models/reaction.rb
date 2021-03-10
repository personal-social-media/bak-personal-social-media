# frozen_string_literal: true

# == Schema Information
#
# Table name: reactions
#
#  id            :bigint           not null, primary key
#  reaction_type :string           not null
#  subject_type  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  peer_info_id  :bigint
#  subject_id    :bigint           not null
#
# Indexes
#
#  index_reactions_on_peer_info_id_and_subject_id  (peer_info_id,subject_id) UNIQUE
#  index_reactions_on_subject                      (subject_type,subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
class Reaction < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :peer_info
  str_enum :reaction_type, %i(like love wow)
  after_create :increment_count!
  after_update :update_count!, if: -> { reaction_type_changed? }

  validates :subject_id, uniqueness: { scope: [:subject_type, :peer_info_id] }

  private
    def increment_count!
      subject.increment!("#{reaction_type}_count")
    end

    def update_count!
      subject.class.transaction do
        subject.decrement!("#{reaction_type_before_last_save}_count")
        subject.increment!("#{reaction_type}_count")
      end
    end
end
