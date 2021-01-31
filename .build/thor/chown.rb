class Chown < Thor
  include Thor::Actions

  desc "default", "chowns dirs"
  def default
    files = Dir.entries("./") - %w[. .. .build]
    run "sudo chown $USER #{files.join(" ")} -R"
  end

  default_task :default
end