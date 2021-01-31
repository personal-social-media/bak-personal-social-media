# frozen_string_literal: true

module Personalsm
  class Bundler
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
        run <<-CMD
cd #{project_root}/ruby/app && \
bundle install && \
yarn install
        CMD
      end
    end
  end
end
