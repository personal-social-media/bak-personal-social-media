# frozen_string_literal: true

module MessagesService
  class UpdateClientMessage
    attr_reader :params, :message
    def initialize(message, params)
      @message = message
      @params = params
    end

    def call!
      message.update!(params)
      message.sync_update
    end
  end
end
