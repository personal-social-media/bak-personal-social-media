# frozen_string_literal: true

module CacheReactionsService
  class Index
    attr_reader :search
    def initialize(search)
      @search = search.first(200)
    end

    def call!
      arel_query = search.map { |(subject_id, subject_type)|
        arel_table[:subject_id].eq(subject_id).and(
          arel_table[:subject_type].eq(subject_type)
        )
      }.reduce(:or)

      CacheReaction.where(arel_query)
    end
  end
end
