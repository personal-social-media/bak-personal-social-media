# frozen_string_literal: true

module MessagesService
  class CreateMessage
    attr_reader :conversation, :params, :message
    def initialize(conversation, params)
      @conversation = conversation
      @params = params
    end

    def call!
      Message.transaction do
        create_message!
        update_conversation!
        update_notification!
      end
      message
    end

    private
      def create_message!
        @message = Message.new(params).tap do |message|
          message.conversation = conversation

          message.save!
        end
      end

      def update_conversation!
        conversation.update!(has_new_messages: true)
      end

      def update_notification!
        if notification.seen?
          notification.update!(seen: false, metadata: {
            new_message_count: 0
          })
        else
          notification.update!(metadata: {
            new_message_count: current_new_message_count + 1
          })
        end
      end

      def current_new_message_count
        notification.metadata["new_message_count"] || 0
      end

      def notification
        @notification ||= Notification.find_or_initialize_by(subject: conversation, notification_type: :new_message)
      end
  end
end
