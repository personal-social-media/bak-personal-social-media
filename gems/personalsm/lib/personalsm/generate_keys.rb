# frozen_string_literal: true

module Personalsm
  class GenerateKeys
    include Ssh
    attr_reader :host, :user, :app_name

    def initialize(host, user, app_name, ssh = nil, sftp = nil)
      @host = host
      @user = user
      @app_name = app_name.gsub(/\s/, "")
      @ssh = ssh
      @sftp = sftp
    end

    def call!
      start_sftp(host, user) do
        upload!(private_key_file.path, project_root + "/keys/private_key.pem")
        upload!(public_key_file.path, project_root + "/keys/public_key.pem")
      end
      private_key_file.unlink
      public_key_file.unlink
    end

    def keys
      new_keys
    end

    def new_keys
      @new_keys ||= OpenSSL::PKey::RSA.new(2048)
    end

    def private_key_file
      return @private_key_file if defined? @private_key_file
      @private_key_file = Tempfile.new.tap do |f|
        f.write(keys.to_pem)
        f.rewind
        f.close
      end
    end

    def public_key_file
      return @public_key_file if defined? @public_key_file
      @public_key_file = Tempfile.new.tap do |f|
        f.write(keys.public_key.to_pem)
        f.rewind
        f.close
      end
    end
  end
end
