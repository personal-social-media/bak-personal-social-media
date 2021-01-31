class Docker < Thor
  include Thor::Actions

  desc "bash", "starts docker bash"
  def bash
    run "docker-compose run app bash"
  end

  desc "up", "starts docker up"
  def up
    run "docker-compose up"
  end

  default_task :bash
end