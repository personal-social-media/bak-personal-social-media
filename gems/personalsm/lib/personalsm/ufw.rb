# frozen_string_literal: true

module Personalsm
  class Ufw
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
    end

    def configure
    end
  end
end
