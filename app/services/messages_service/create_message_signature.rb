# frozen_string_literal: true

module MessagesService
  class CreateMessageSignature
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def call!
      message.signature = SignaturesService::Sign.new(signature).call!
    end

    private
      def signature
        message.payload.to_json
      end
  end
end
