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
      Comment.create!(peer_info: peer, subject: subject, payload: payload, signature: signature, parent_comment: parent_comment)
    end

    def parent_comment
      return nil if payload[:parent_comment_id].blank?
      Comment.find(payload[:parent_comment_id])
    end
  end
end
