# frozen_string_literal: true

module ReactionsService
  class CurrentSubject
    attr_reader :subject_type, :subject_id

    def initialize(params)
      @subject_type = params[:subject_type]
      @subject_id = params[:subject_id]
    end

    def call!
      return nil if subject_type.blank? || subject_id.blank?

      return find_post if subject_type == "post"
      return find_message if subject_type == "message"
      find_comment if subject_type == "comment"
    end

    private
      def find_post
        Post.find_by(uid: subject_id)
      end

      def find_comment
        Comment.find_by(uid: subject_id)
      end

      def find_message
        Message.find_by(id: subject_id)
      end
  end
end
