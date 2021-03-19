# frozen_string_literal: true

module VerificationResultsService
  class CreateVerificationResult
    extend Memoist
    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call!
      VerificationResult.create!(subject: subject, remote_id: remote_id, remote_type: remote_type, peer_info: peer_info)
    end

    private
      memoize def subject
        FeedItem.find_by(uid: remote_id) if %w(post story).include?(remote_type)
      end

      def remote_id
        params[:remote_id]
      end

      def remote_type
        params[:remote_type]
      end

      def peer_info
        PeerInfo.find_by!(id: params[:peer_info_id])
      end
  end
end
