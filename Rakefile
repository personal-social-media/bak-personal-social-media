# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

def initialize(host, user, password, app_name, ssh = nil, sftp = nil)
  @host = host
  @user = user
  @password = password
  @app_name = app_name.gsub(/\s/, "")
  @ssh = ssh
  @sftp = sftp
end
