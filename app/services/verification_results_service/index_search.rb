# frozen_string_literal: true

module VerificationResultsService
  class IndexSearch
    attr_reader :search, :klass
    def initialize(search)
      @search = search.first(200)
      @klass = VerificationResult
    end

    def call!
      return [] if search.blank?
      arel_query = search.map do |item|
        arel_table[:remote_id].eq(item[:remote_id]).and(
          arel_table[:remote_type].eq(item[:remote_type])
        )
      end.reduce(:or)

      where(arel_query)
    end

    delegate :where, :arel_table, to: :klass
  end
end
