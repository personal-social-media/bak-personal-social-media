# frozen_string_literal: true

module ReactionsService
  class CreateReaction
    attr_reader :peer, :subject, :reaction_type

    def initialize(peer, subject, reaction_type)
      @peer = peer
      @subject = subject
      @reaction_type = reaction_type
    end

    def call!
      Reaction.create!(peer_info: peer, subject: subject, reaction_type: reaction_type)
    end
  end
end
