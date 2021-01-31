# frozen_string_literal: true

require "thor"

module Personalsm
  class Cli < Thor
    desc "version", "show version"
    def version
      puts "Personalsm CLI v #{Personalsm::VERSION}"
    end

    desc "setup-server", "sets up server"
    method_options host: :string, user: :string
    def setup_server(name)
      Personalsm::SetupAllInOne.new(options[:host], options[:user], name).call!
    end

    desc "fix-ssh", "fixes error to ssh"
    def fix_ssh
      exec('killall ssh-agent; eval "$(ssh-agent)";')
    end
  end
end
