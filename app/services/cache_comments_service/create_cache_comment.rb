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

      response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url, json: body)
      raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399

      remote_id = JSON.parse(response.body.to_s).dig("comment", "id")

      CacheComment.create!(subject: subject, payload: payload, remote_id: remote_id, peer_info: peer_info,
                           payload_subject_type: payload_subject_type, payload_subject_id: payload_subject_id)
    end

    private
      def timeout
        10
      end

      def body
        {
          comment: {
            subject_id: payload_subject_id,
            subject_type: payload_subject_type,
            parent_comment_id: parent_comment_id,
            payload: payload,
            signature: SignaturesService::Sign.new(payload.to_json).call!
          }
        }
      end

      def url
        "https://#{peer_info.ip}/api/comments"
      end

      def existing_record
        CacheComment.find_by(payload_subject_id: payload_subject_id, payload_subject_type: payload_subject_type)
      end

      memoize def subject
        FeedItem.find_by(uid: payload_subject_id) if %w(post story).include?(payload_subject_type)
      end

      def payload_subject_type
        create_params[:payload_subject_type]
      end

      def payload_subject_id
        create_params[:payload_subject_id]
      end

      def payload
        create_params[:payload]
      end

      def parent_comment_id
        create_params[:parent_comment_id]
      end

      memoize def peer_info
        PeerInfo.find_by!(id: create_params[:peer_info_id])
      end
  end
end
