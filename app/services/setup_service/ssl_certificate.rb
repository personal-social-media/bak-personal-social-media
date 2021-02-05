# frozen_string_literal: true

module SetupService
  class SslCertificate
    attr_reader :cert

    def fetch
      @cert = HTTP.post("https://registry.personalsocialmedia.net/ssl")
      raise "error request" if cert.status > 399

      @cert = @cert.body.to_s
      self
    end

    def write
      return unless Rails.env.production?
      File.open(path, "w") do |f|
        f.write(cert)
      end
      p "new ssl certificate added"
    end

    def path
      Rails.application.secrets.dig(:profile, :keys_location) + "/ssl_cert.pem"
    end
  end
end
