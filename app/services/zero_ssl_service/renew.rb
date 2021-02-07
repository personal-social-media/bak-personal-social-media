# frozen_string_literal: true

module ZeroSslService
  class Renew
    attr_reader :is_new, :order
    extend Memoist

    def call!
      private_key

      make_order
      handle_keys
    end

    private
      def make_order
        @order = client.new_order(identifiers: [domain])

        order.authorizations.each do |authorization|
          p ["validating", authorization.domain]
          challenge = authorization.http

          # write challange data to challenge.filename
          file_path = Rails.root.join("public", File.dirname(challenge.filename))
          FileUtils.mkdir_p(file_path)
          File.write(file_path, challenge.file_content)

          # validate single domain
          challenge.request_validation
          while challenge.status == "pending"
            p ["challenge.status", challenge.status]
            sleep(2)
            challenge.reload
          end
          p challenge.status # => 'valid'
        end
      end

      def handle_keys
        pk = OpenSSL::PKey::RSA.new(4096)
        csr = Acme::Client::CertificateRequest.new(private_key: pk, names: [domain])
        order.finalize(csr: csr)
        while order.status == "processing"
          sleep(1)
          challenge.reload
        end
        # save certificate and private key
        if (certificate = order.certificate)
          File.write(ssl_pk_path, private_key.to_pem)
          File.write(ssl_cert_path, certificate)
        else
          p "error renewing"
        end
      end

      memoize def client
        Acme::Client.new(private_key: private_key, directory: directory).tap do |c|
          next unless is_new
          c.new_account(contact: "mailto:mail@drgcms.org", terms_of_service_agreed: true)
        end
      end

      def private_key
        if File.exist?(target_private)
          return OpenSSL::PKey::RSA.new(target_private)
        end

        @is_new = true
        OpenSSL::PKey::RSA.new(4096)
      end

      def target_private
        root + "/ssl_private_key.pem"
      end

      def root
        Rails.application.secrets.dig(:profile, :keys_location)
      end

      memoize def domain
        URI.parse(Rails.application.secrets.dig(:load_balancer_address)).host
      end

      def directory
        "https://acme-v02.api.letsencrypt.org/directory"
      end

      def ssl_cert_path
        root_ssl + "/certificate.crt"
      end

      def ssl_pk_path
        root_ssl + "/private.key"
      end

      def root_ssl
        Rails.application.secrets.dig(:profile, :keys_location)
      end
  end
end
