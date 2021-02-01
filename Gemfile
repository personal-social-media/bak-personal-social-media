# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.1.1"
gem "pg", "~> 1.1"
gem "sass-rails", ">= 6"
gem "bootsnap", ">= 1.4.4", require: false

group :development do
  gem "web-console", ">= 4.1.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

# end default rails

group :development do
  gem "annotate", "~> 3.1", ">= 3.1.1"
  gem "foreman", "~> 0.87.2"
  gem "spring-commands-rspec"
  gem "rack-mini-profiler"
  gem "memory_profiler"
  gem "stackprof"
end

group :development, :test do
  gem "rubocop-rails_config", "~> 1.2", ">= 1.2.1"
  gem "rspec-rails", "~> 4.0", ">= 4.0.2"
  gem "factory_bot_rails", "~> 6.1"
  gem "bundler-audit"
  gem "brakeman"
  gem "pry-rails", "~> 0.3.9"
  gem "erb_lint", require: false
end

group :production do
  gem "dotenv", "~> 2.7", ">= 2.7.6"
  gem "bugsnag"
end

group :test do
  gem "database_cleaner", "~> 1.8", ">= 1.8.5"
end

gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "jb", "~> 0.8.0"
gem "str_enum", "~> 0.2.0"
gem "memoist", "~> 0.16.2"
gem "auto_strip_attributes"
gem "falcon"
gem "http"
gem "font-awesome-rails"
gem "shrine", "~> 3.3"
gem "hiredis", "~> 0.6.3", require: %w(redis redis/connection/hiredis)
gem "sidekiq", "~> 6.1", ">= 6.1.2", require: %w(sidekiq/web)
gem "rack-cors"
gem "oj"
gem "ruby-vips"
gem "image_processing", "~> 1.12", ">= 1.12.1"
gem "fastimage", "~> 2.2", ">= 2.2.2"
gem "marcel", "~> 0.3.3"
gem "exiftool_vendored"
gem "exiftool"
gem "toastr-rails"
gem "jquery-rails", "~> 4.4"
gem "view_component", require: "view_component/engine"
gem "react-rails"
gem "webpacker", "~> 5.2", ">= 5.2.1"
