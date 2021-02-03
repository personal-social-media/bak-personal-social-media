# frozen_string_literal: true

module PeerInfoWorker
  class FetchInfo < ApplicationWorker
    attr_reader :peer_info
    def perform(peer_info_id)
      @peer_info = PeerInfo.find_by(id: peer_info_id)
      return if peer_info.blank?

      call!
    end

    private
      def call!
      end
  end
end
