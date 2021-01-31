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

  desc "debug", "starts docker up"
  def debug
    opened_containers = `docker ps`.split("\n")
    backend = nil

    opened_containers.reverse_each do |c|
      line = c.split(" ")
      if line[1] == "personal-social-media_app"
        backend = line.last
        break
      end
    end
    run "docker attach #{backend}"
  end

  default_task :bash
end