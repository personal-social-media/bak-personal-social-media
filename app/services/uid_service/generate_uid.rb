# frozen_string_literal: true

module UidService
  class GenerateUid
    attr_reader :record
    def initialize(record)
      @record = record
    end

    def call!
      return generate_test if is_test?
      generate
    end

    private
      def generate_test
        record.uid ||= "UID-#{SecureRandom.hex(24)}"
      end

      def is_test?
        Rails.env.test?
      end

      def generate
        record.uid = SecureRandom.hex(24)
      end
  end
end
