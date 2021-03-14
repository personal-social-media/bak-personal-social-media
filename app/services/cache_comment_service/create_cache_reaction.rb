# frozen_string_literal: true

module CacheCommentsService
  class CreateCacheComment
    class Error < Exception; end
    include IdentityService::SignedRequest
    extend Memoist

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call!
      return if existing_record.present?
      raise Error, "subject not found" if subject.blank?

      response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url, json: body)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      remote_id = JSON.parse(response.body.to_s).dig("comment", "id")

      CacheComment.create!(subject: subject, comment_type: create_params[:comment_type], remote_id: remote_id)
    end

    private
      def timeout
        10
      end

      def body
        {
          comment: {
            comment_type: create_params[:comment_type],
            subject_id: payload_subject_id,
            subject_type: payload_subject_type,
          }
        }
      end

      def url
        "https://#{peer_info.ip}/api/comments"
      end

      def existing_record
        CacheComment.find_by(subject_id: create_params[:subject_id], subject_type: create_params[:subject_type])
      end

      memoize def subject
        model.find_by!(id: create_params[:subject_id])
      end

      memoize def model
        raise Error, "invalid subject type" unless %w(FeedItem).include?(create_params[:subject_type])

        create_params[:subject_type].constantize
      end

      def payload_subject_type
        if subject.is_a?(FeedItem)
          subject.feed_item_type
        end
      end

      def payload_subject_id
        if subject.is_a?(FeedItem)
          subject.uid
        end
      end

      delegate :peer_info, to: :subject
  end
end
