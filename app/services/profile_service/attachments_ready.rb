# frozen_string_literal: true

module ProfileService
  class AttachmentsReady
    attr_reader :current_user

    def initialize(current_user)
      @current_user = current_user
    end

    def call!
      return if current_avatar.blank?

      Profile.transaction do
        create_post!
        update_peer_info
      end
    end

    private
      def create_post!
        post = Post.create!(content: "Changed profile picture")
        current_avatar.dup.tap do |new_attachment|
          new_attachment.subject = post
          new_attachment.save!
        end
        post.sync_create
      end

      def update_peer_info
        if current_user.profile_image.present?
          peer_info.avatars = AttachmentsService::UrlFor.new(current_avatar.attachment, nil).all_urls
        end

        peer_info.save!
      end

      delegate :current_avatar, :peer_info, to: :current_user
  end
end
