# frozen_string_literal: true

class MessagePresenter
  attr_reader :message
  def initialize(message)
    @message = message
  end

  def render
    message.as_json(only: %i(id message_owner remote_id message_type payload processing_status read created_at conversation_id))
  end
end
