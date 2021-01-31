# frozen_string_literal: true

module Personalsm
  class Packages
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
        run("sudo apt-get update -y")
        run("sudo apt-get upgrade -y")
        run("sudo apt-get install -y #{packages.join(" ")}")

        install_node
        # install_rbenv
        # install_ruby
      end
    end

    def install_node
      return if executable_exists?("node") && run("node -v").match(/#{node_version}/)

      run "curl -sL https://deb.nodesource.com/setup_14.x | sudo bash"
      run "sudo apt-get install -y nodejs yarn"
    end

    def install_rbenv
      return if executable_exists?("rbenv")
      run "git clone https://github.com/rbenv/rbenv.git ~/.rbenv"
      run <<-CMD
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
      CMD

      run <<-CMD
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
      CMD
      run "source ~/.bashrc"
      run "git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build"
    end

    def install_ruby
      ruby_version = run("cat #{project_root}/ruby/app/.ruby-version")
      run "rbenv install #{ruby_version}", "Install ruby version"
    end

    def node_version
      "14"
    end

    def packages
      %w(
autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
gcc g++ make
libpq-dev
libmagickwand-dev
vim
git
curl
      )
    end
  end
end
