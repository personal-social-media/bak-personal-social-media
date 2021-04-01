# frozen_string_literal: true

class MessagesChannel
  class PushMessage < NotificationsService::BasePush
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def call!
      push(MessagePresenter.new(message).render)
    end

    def push(data)
      ActionCable.server.broadcast("messages", { message: data })
    end
  end
end
