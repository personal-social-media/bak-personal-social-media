# frozen_string_literal: true

module Personalsm
  class Env
    include Ssh
    attr_reader :host, :user, :app_name, :login_token

    def initialize(host, user, app_name, ssh = nil, sftp = nil)
      @host = host
      @user = user
      @app_name = app_name.gsub(/\s/, "")
      @ssh = ssh
      @sftp = sftp
    end

    def call!
      setup_env

      start_sftp(host, user) do
        upload!(env_file.path, project_root + "/keys/.env")
      end
      env_file.unlink
      self
    end

    def setup_env
      @secret_key_base = SecureRandom.hex(64)
      @time_zone = Time.now.zone
      @load_balancer_address = "https://#{host}"
      @login_token = SecureRandom.hex(64)
      @keys_location = project_root + "/keys"
    end

    def env_file
      return @env_file if defined? @env_file
      @env_file = Tempfile.new.tap do |f|
        content = ERB.new(File.read(File.dirname(__FILE__) + "/env/.env.erb")).result(binding)

        f.write(content)
        f.rewind
        f.close
      end
    end
  end
end
