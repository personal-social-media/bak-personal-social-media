# frozen_string_literal: true

module SetupService
  class GenerateKeys
    attr_reader :private_key

    def make_dir
      FileUtils.mkdir_p(root)
      self
    end

    def check?
      !File.exist?(target_private)
    end

    def generate_keys
      @private_key = OpenSSL::PKey::RSA.new(4096)
      self
    end

    def write_keys!
      return unless Rails.env.production?
      File.open(target_private, "w") do |f|
        f.write(private_key.to_pem)
      end

      File.open(target_public, "w") do |f|
        f.write(private_key.public_key.to_pem)
      end
    end

    private
      def target_private
        root + "/private_key.pem"
      end

      def target_public
        root + "/public_key.pem"
      end

      def root
        Rails.application.secrets.dig(:profile, :keys_location)
      end
  end
end
