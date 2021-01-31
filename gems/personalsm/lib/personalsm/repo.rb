# frozen_string_literal: true

module Personalsm
  class Repo
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
      start_ssh(host, user) do
        clone
      end
    end

    def clone
      run "git clone https://github.com/personal-social-media/personal-social-media.git #{project_root}/ruby"
    end
  end
end
