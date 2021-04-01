# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id                :bigint           not null, primary key
#  message_owner     :string           default(""), not null
#  message_type      :string           not null
#  payload           :text             default({}), not null
#  processing_status :string           default("processing"), not null
#  read              :boolean          default(FALSE), not null
#  signature         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  conversation_id   :bigint           not null
#  remote_id         :bigint
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_remote_id        (remote_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#
class Message < ApplicationRecord
  belongs_to :conversation, counter_cache: true
  has_one :peer_info, through: :conversation
  str_enum :message_type, %i(text)
  str_enum :processing_status, %i(processing processed)
  str_enum :message_owner, %i(self peer)
  has_one :reaction, as: :subject, dependent: :destroy
  has_many :attached_files, as: :subject, dependent: :destroy
  validate :validate_signature, if: -> { peer? }, on: :create
  validates :remote_id, presence: true, uniqueness: { scope: :conversation_id }, if: -> { peer? }
  unless Rails.env.test?
    after_commit :push_message, on: :create, if: -> { peer? }
    after_commit :push_message, on: :update, if: -> { self? }
  end

  serialize :payload, JSON

  def sync_create
    SyncWorker.perform_async(Message, id, SyncService::SyncMessage, :call_create!)
  end

  def sync_update
    SyncWorker.perform_async(Message, id, SyncService::SyncMessage, :call_update!)
  end

  def generate_signature!
    self.signature = MessagesService::CreateMessageSignature.new(self).call!
    self.save!
  end

  def attachments_ready!
    sync_create
  end

  def no_reactions_counter
    true
  end

  def push_message
    MessagesChannel::PushMessage.new(self).call!
  end

  private
    def validate_signature
      errors.add(:payload, :invalid) unless PeerInfoService::ValidateSignedContent.new(peer_info, payload.to_json, signature, decode: true).call!
    end
end
