# frozen_string_literal: true

module RedisService
  class Url
    class << self
      def get_url
        Rails.application.secrets.dig(:redis, :url)
      end

      def build_sidekiq_config
        { url: get_url, driver: :hiredis }
      end
    end
  end
end
