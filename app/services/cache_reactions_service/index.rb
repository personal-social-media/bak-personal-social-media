# frozen_string_literal: true

module CacheReactionsService
  class Index
    attr_reader :search, :klass
    def initialize(search)
      @search = search.first(200)
      @klass = CacheReaction
    end

    def call!
      return [] if search.blank?
      arel_query = search.map { |item|
        arel_table[:payload_subject_id].eq(item[:payload_subject_id]).and(
          arel_table[:payload_subject_type].eq(item[:payload_subject_type])
        )
      }.reduce(:or)

      where(arel_query)
    end

    delegate :where, :arel_table, to: :klass
  end
end
