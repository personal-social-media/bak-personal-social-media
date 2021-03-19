# frozen_string_literal: true

module CacheReactionsService
  class CreateCacheReaction
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

      remote_id = JSON.parse(response.body.to_s).dig("reaction", "id")

      CacheReaction.create!(subject: subject, reaction_type: reaction_type, remote_id: remote_id, peer_info: peer_info,
                            payload_subject_type: payload_subject_type, payload_subject_id: payload_subject_id)
    end

    private
      def timeout
        10
      end

      def body
        {
          reaction: {
            reaction_type: reaction_type,
            subject_id: payload_subject_id,
            subject_type: payload_subject_type,
          }
        }
      end

      def url
        "https://#{peer_info.ip}/api/reactions"
      end

      def existing_record
        CacheReaction.find_by(payload_subject_type: payload_subject_type, payload_subject_id: payload_subject_id)
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

      def reaction_type
        create_params[:reaction_type]
      end

      memoize def peer_info
        PeerInfo.find_by!(id: create_params[:peer_info_id])
      end
  end
end
