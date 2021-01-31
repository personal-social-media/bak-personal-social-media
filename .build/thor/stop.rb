class Stop < Thor
  include Thor::Actions

  desc "default", "stops docker"
  def default
    run 'docker stop $(docker ps -a -q)'
  end

  default_task :default
end