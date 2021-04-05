# frozen_string_literal: true

module CommentsService
  class CurrentSubject
    attr_reader :subject_type, :subject_id

    def initialize(params)
      @subject_type = params[:subject_type]
      @subject_id = params[:subject_id]
    end

    def call!
      return nil if subject_type.blank? || subject_id.blank?

      find_post if subject_type == "post"
    end

    private
      def find_post
        Post.find_by(uid: subject_id)
      end
  end
end
