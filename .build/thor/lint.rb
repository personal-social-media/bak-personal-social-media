class Lint < Thor
  include Thor::Actions

  desc "default", "lint everything"
  def default
    run "bundle exec rubocop -A"
    run "bundle exec erblint --lint-all -a"
    run "yarn lint"
  end

  desc "test", "lint test everything"
  def test
    run "bundle exec rubocop --parallel"
    run "bundle exec erblint --lint-all"
    run "yarn eslint --ext .js --ext .jsx app/javascript"
  end

  default_task :default
end