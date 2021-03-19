# frozen_string_literal: true

module VerificationResultsService
  class CreateVerificationResult
    extend Memoist
    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call!
      VerificationResult.create!(subject: subject, remote_id: remote_id, remote_type: remote_type)
    end

    private
      memoize def subject
        if params[:subject_type] == "FeedItem"
          FeedItem.find_by!(id: params[:subject_id])
        end
      end

      def remote_id
        if subject.is_a?(FeedItem)
          subject.uid
        end
      end

      def remote_type
        if subject.is_a?(FeedItem)
          subject.feed_item_type
        end
      end
  end
end
