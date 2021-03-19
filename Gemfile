# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
is_dev = !!ENV["DEVELOPER"]

ruby "2.7.2"

gem "bootsnap", "~> 1.7.2", require: false
gem "pg", "~> 1.1"
gem "rails", "~> 6.1.3"
gem "sass-rails", ">= 6"

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

# end default rails

group :development do
  gem "annotate", "~> 3.1", ">= 3.1.1"
  gem "better_errors", "~> 2.9", ">= 2.9.1"
  gem "binding_of_caller", "~> 1.0"
  gem "foreman", "~> 0.87.2"
  gem "memory_profiler"
  gem "rack-mini-profiler"
  gem "spring-commands-rspec"
  gem "stackprof"
end

group :development, :test do
  gem "brakeman"
  gem "bundler-audit"
  gem "erb_lint", require: false
  gem "factory_bot_rails", "~> 6.1"
  gem "pg_query", "~> 2.0"
  gem "prosopite"
  gem "pry-rails", "~> 0.3.9"
  gem "rspec-rails", "~> 5.0"
  gem "rubocop-rails_config", "~> 1.3"
end

group :production do
  gem "bugsnag"
  gem "dotenv", "~> 2.7", ">= 2.7.6"
  gem "uglifier", "~> 4.2"
end

group :test do
  gem "capybara"
  gem "codecov", require: false
  gem "database_cleaner", "~> 2.0"
  gem "poltergeist"
  gem "rspec-retry"
  gem "vcr", "~> 6.0"
  gem "webmock"
end

gem "acme-client"
gem "auto_strip_attributes"
gem "base32", "~> 0.3.4"
gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "bullet", "~> 6.1"
gem "cities", "~> 0.3.1"
gem "countries", "~> 3.0", ">= 3.0.1"
gem "curb"
gem "exiftool"
gem "exiftool_vendored"
gem "fastimage", "~> 2.2"
gem "ffi", "~> 1.15"
gem "font-awesome-rails"
gem "hiredis", "~> 0.6.3", require: %w(redis redis/connection/hiredis)
gem "http"
gem "image_processing", "~> 1.12", ">= 1.12.1"
gem "jb", "~> 0.8.0"
gem "jquery-rails", "~> 4.4"
gem "kaminari"
gem "marcel", "~> 0.3.3"
gem "memoist", "~> 0.16.2"
gem "offline_geocoder", "~> 0.2.1"
gem "oj"
gem "pghero"
gem "pg_search"
gem "puma", "~> 5.2"
gem "rack-cors"
gem "rails_admin", require: is_dev
gem "react-rails"
gem "ruby-vips"
gem "secure_headers", "~> 6.3", ">= 6.3.2"
gem "serviceworker-rails"
gem "shrine", "~> 3.3"
gem "sidekiq", "~> 6.2", require: %w(sidekiq/web)
gem "sidekiq-cron", "~> 1.2", require: %w(sidekiq/cron/web)
gem "sidekiq-throttled", require: "sidekiq/throttled"
gem "streamio-ffmpeg", github: "streamio/streamio-ffmpeg"
gem "str_enum", "~> 0.2.0"
gem "toastr-rails"
gem "typhoeus", "~> 1.4"
gem "validate_url"
gem "view_component", require: "view_component/engine"
gem "webpacker", "~> 5.2", ">= 5.2.1"
