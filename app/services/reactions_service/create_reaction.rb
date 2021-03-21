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
      return if notification.updated_at.present? && notification.updated_at > 30.minutes.ago

      subject.reload
      notification.metadata = {
        total_reactions: total_reactions,
        last_peer: {
          id: peer.id,
          name: peer.name
        }
      }
      notification.save!
    end

    private
      def notification
        @notification ||= Notification.find_or_initialize_by(notification_type: :reaction, subject: subject)
      end

      def total_reactions
        subject.like_count + subject.love_count + subject.wow_count
      end
  end
end
