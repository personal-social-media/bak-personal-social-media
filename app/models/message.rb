# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id                :bigint           not null, primary key
#  message_type      :string           not null
#  payload           :text             default("{}"), not null
#  processing_status :string           default("processing"), not null
#  read              :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  conversation_id   :bigint           not null
#  remote_id         :bigint
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#
class Message < ApplicationRecord
  belongs_to :conversation
  str_enum :message_type, %i(text)
  str_enum :processing_status, %i(processing processed)

  serialize :payload, JSON
end
