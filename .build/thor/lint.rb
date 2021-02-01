class Lint < Thor
  include Thor::Actions

  desc "default", "lint everything"
  def default
    run "bundle exec rubocop -A"
    run "bundle exec erblint --lint-all -a"
    run "yarn lint"
  end

  default_task :default
end