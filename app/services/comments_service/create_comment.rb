# frozen_string_literal: true

module CommentsService
  class CreateComment
    attr_reader :peer, :subject, :payload, :signature

    def initialize(peer, subject, payload, signature)
      @peer = peer
      @subject = subject
      @payload = payload
      @signature = signature
    end

    def call!
      Comment.create!(peer_info: peer, subject: subject, payload: payload, signature: signature)
    end
  end
end
