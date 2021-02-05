# frozen_string_literal: true

module SetupService
  class Checks
    attr_reader :error
    def ok?
      time_zone && load_balancer_address && storage && keys_location &&
        ssl_key && private_key
    end

    private
      def time_zone
        if Rails.application.secrets.dig(:time_zone).present?
          true
        else
          @error = "ENV TIME_ZONE not set"
          false
        end
      end

      def load_balancer_address
        if Rails.application.secrets.dig(:load_balancer_address).present?
          true
        else
          @error = "ENV LOAD_BALANCER_ADDRESS not set"
          false
        end
      end

      def storage
        if Rails.application.secrets.dig(:storage).present?
          true
        else
          @error = "ENV STORAGE not set"
          false
        end
      end

      def keys_location
        if Rails.application.secrets.dig(:profile, :keys_location).present?
          true
        else
          @error = "ENV KEYS_LOCATION not set"
          false
        end
      end

      def ssl_key
        path = Rails.application.secrets.dig(:profile, :keys_location) + "/ssl_cert.pem"
        if File.exist?(path)
          true
        else
          @error = "NO SSL certificate, please run bundle exec psm:fetch_ssl_cert"
        end
      end

      def private_key
        path = Rails.application.secrets.dig(:profile, :keys_location) + "/private_key.pem"
        if File.exist?(path)
          true
        else
          @error = "NO PRIVATE KEY, please run bundle exec psm:generate_keys"
        end
      end
  end
end
