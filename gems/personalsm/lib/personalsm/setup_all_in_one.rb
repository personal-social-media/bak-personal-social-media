# frozen_string_literal: true

module Personalsm
  class SetupAllInOne
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
      start_ssh(host, user) do
        # make_dir
        # GenerateKeys.new(host, user, app_name, @ssh, @sftp).call!
        @env = Env.new(host, user, app_name, @ssh, @sftp).call!
        # Repo.new(host, user, app_name, @ssh, @sftp).call!
        # Packages.new(host, user, app_name, @ssh, @sftp).call!
        Bundler.new(host, user, app_name, @ssh, @sftp).call!
      end
    end

    private
      def make_dir
        run("mkdir -p #{project_root} #{project_root}/keys #{project_root}/ruby", "Create server directory")
      end
  end
end
