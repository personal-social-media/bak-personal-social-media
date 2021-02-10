# frozen_string_literal: true

module PreviousSearchesService
  class Create
    extend Memoist
    class PeerInfoNotFound < Exception; end

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call!
      PreviousSearch.find_or_initialize_by(peer_info: peer_info).tap do |search|
        search.updated_at = Time.zone.now
        search.save!
      end
    end

    memoize def peer_info
      PeerInfo.find_by(id: create_params[:id]).tap do |peer_info|
        raise PeerInfoNotFound, "peer not found" if peer_info.blank?
      end
    end
  end
end
