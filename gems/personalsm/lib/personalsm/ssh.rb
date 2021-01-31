# frozen_string_literal: true

require "net/ssh"
require "net/sftp"
require "colorize"

module Personalsm
  module Ssh
    def run(cmd, comment = nil)
      time = Time.now.strftime("%H:%M:%S ").colorize(:green)
      message = time + cmd.colorize(:blue)
      if comment
        message += " # #{comment}"
      end
      print "#{message}\n"

      @ssh.exec!(cmd)
    end

    def start_ssh(host, username)
      return yield if @ssh

      Net::SSH.start(host, username) do |ssh|
        @ssh = ssh
        yield
      end
    end

    def upload!(local, remote, comment = nil)
      time = Time.now.strftime("%H:%M:%S ").colorize(:green)
      message = time + "UPLOAD #{local} to #{@sftp_host}#{remote}".colorize(:blue)

      if comment
        message += " # #{comment}"
      end
      print "#{message}\n"

      @sftp.upload!(local, remote)
    end

    def start_sftp(host, username)
      @sftp_host = host
      return yield if @sftp

      Net::SFTP.start(host, username) do |sftp|
        @sftp = sftp
        yield
      end
    end

    def project_root
      "/var/www/html/#{app_name}"
    end

    def executable_exists?(name)
      run("which #{name}").size > 0
    end
  end
end
